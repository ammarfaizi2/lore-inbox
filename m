Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154044-31090>; Thu, 17 Dec 1998 10:29:50 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:2262 "EHLO saturn.cs.uml.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154112-31090>; Thu, 17 Dec 1998 10:28:15 -0500
Date: Thu, 17 Dec 1998 11:09:30 -0500 (EST)
Message-Id: <199812171609.LAA01324@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.rutgers.edu
Subject: Re: autofs vs. Sun automount -- new fs proposal
Sender: owner-linux-kernel@vger.rutgers.edu


Peter Benie writes:
> Stefan Monnier <monnier+misc/news@tequila.cs.yale.edu> wrote:
>> pjb1008@cam.ac.uk (Peter Benie) wrote:

>>> I don't actually see the point of implementing a read-only loopback
>>> mount. There are already protection mechanisms in the kernel to
>>> prevent one user from writing to another user's files. If you need to
>>> run a program so that it cannot write to any files, just run the
>>> program under a different uid.
>>
>> Following the same reasoning: why allow things like `chmod u-w' since
>> the user can change it back anyway !
> 
> Huh? I can't see how that follows, and I don't understand the point
> that you're trying to make.
> 
> What I'm saying is that there are standard ways under Unix to stop
> programs from writing to your files
...
> To use the kernel's existing protection mechanisms that protect
> non-zero uids from each other.


Those protection mechanisms are likely to fail.
The NSA even has a report on the failure of normal access control:

        http://www.jya.com/paperF1.htm

The report explains why access control failure is inevitable, at least
with the normal controls provided by unix and NT. They advocate some
more advanced methods that help prevent mistakes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
