Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153997-662>; Fri, 9 Oct 1998 10:50:56 -0400
Received: from twin.uoregon.edu ([128.223.32.106]:1156 "EHLO twin.uoregon.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <156090-662>; Fri, 9 Oct 1998 09:13:49 -0400
Date: Fri, 9 Oct 1998 11:48:09 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Riley Williams <rhw@bigfoot.com>, simon@koala.ie, linux-kernel@vger.rutgers.edu
Subject: Re: network nicety
In-Reply-To: <m0zRfh1-0007U1C@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.981009113809.644E-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Fri, 9 Oct 1998, Alan Cox wrote:

> > Sure - you're saying that just because you're downloading an
> > application for a customer, nobody else should be able to use that
> > link - and I have to say that I disagree with that viewpoint.
> 
> TCP/IP doesnt claim to be fair
> 
> > IMHO, the fact that an FTP transfer will automatically grab 100% of
> > the bandwidth of one's primary link given the slightest chance can
> > only be bad - and the same applies to any other protocol. What I'd
> > like to see is some form of bandwidth limiting system which prevents
> > any one protocol from grabbing more than 90% of the bandwidth to
> > itself, but which allows any protocol to use all otherwise unused
> > bandwidth if it needs it, but automatically relinquishes the excess
> > bandwidth as soon as anything else needs it.

If you're running RED enabled router images your tcp connections should
rate adjust quite well provided they lose enough packets. RED unlike most
diffserv/qos schemes you might choose to implement is quite cpu efficient
in terms queue management. Now that Van has moved  from lbnl to cisco
maybe we'll see some more schemes with wider adoption.
 
> Its called CBQ and Linux 2.1.x supports it. Don't expect ISP end user
> ports to support it in the next 5 years however, $10/month customers arent
> worth the CPU cost of such things
> 
> Alan
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/
> 

-------------------------------------------------------------------------- 
Joel Jaeggli				       joelja@darkwing.uoregon.edu    
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
