Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129950AbRANN4y>; Sun, 14 Jan 2001 08:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRANN4o>; Sun, 14 Jan 2001 08:56:44 -0500
Received: from austin.jhcloos.com ([206.224.83.202]:27396 "HELO
	austin.jhcloos.com") by vger.kernel.org with SMTP
	id <S129950AbRANN43>; Sun, 14 Jan 2001 08:56:29 -0500
To: Christoph Rohland <cr@sap.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, david+validemail@kalifornia.com,
        linux-kernel@vger.kernel.org
Subject: Re: shmem or swapfs? was: [Patch] make shm filesystem part configurable
In-Reply-To: <200101132014.f0DKEJh153332@saturn.cs.uml.edu>
	<m3itnih3eb.fsf@linux.local>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <m3itnih3eb.fsf@linux.local>
Date: 14 Jan 2001 07:56:28 -0600
Message-ID: <m37l3yck4z.fsf@austin.jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Rohland <cr@sap.com> writes:

Christoph> OK right now I see two alternatives for the name: "tmpfs"
Christoph> for the SUN admins and "vmfs" for expressing what it does
Christoph> and to be in line with "ramfs". Any votes?

I think vmfs is the better choice.  Not to be gratuitously
incompatable with sun, but there is no guarentee linux's
implementation and sun's will be or remain compatable, so it really
doesn't hurt to choose a name which is more descriptive rather than
that used by someone else's product -- even if the other product is
widely deployed and understood.

>> I'd prefer k for ISO standard and K for base-2.  Of course m isn't
>> millibytes, but that isn't horrible.

Christoph> No, I would go for base-2 only. That's what we typically
Christoph> mean with K and M in the IT world. To be case sensitive is
Christoph> IMHO overkill and confusing.

Unquestionably the Right Thing.  VM is after all being measured, and
RAM is always measured in binary.  (OK, I just *know* someone will
provide a counter-example disproving that assertion -- perhaps the old
36 bit systems?  Or core?  But are there any modern counter-examples?)

-JimC
-- 
James H. Cloos, Jr.  <http://jhcloos.com/public_key>     1024D/ED7DAEA6 
<cloos@jhcloos.com>  E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
