Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbRBBWjB>; Fri, 2 Feb 2001 17:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbRBBWiv>; Fri, 2 Feb 2001 17:38:51 -0500
Received: from arthur.runestig.com ([195.67.47.226]:28432 "EHLO
	arthur.runestig.com") by vger.kernel.org with ESMTP
	id <S130339AbRBBWik>; Fri, 2 Feb 2001 17:38:40 -0500
Message-ID: <003e01c08d68$fd5b53f0$0201010a@runestig.com>
From: "Peter 'Luna' Runestig" <peter@runestig.com>
To: "Linux Kernel Mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <003c01c08633$9839c1f0$0201010a@runestig.com>
Subject: Re: PROBLEM: 2.2.19pre7 opps on low mem machine
Date: Fri, 2 Feb 2001 23:39:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Peter 'Luna' Runestig" <peter@runestig.com>
To: "Linux Kernel Mailing list" <linux-kernel@vger.kernel.org>
Sent: Wednesday, January 24, 2001 7:29 PM
Subject: PROBLEM: 2.2.19pre7 opps on low mem machine


> [1.] One line summary of the problem:
> Oops with 2.2.19pre7 on memory stressed, old PC.
>
> [2.] Full description of the problem/report:
> An old 486/66 with 20 Meg memory runs a a firewall at home. Probably runs
> too much for that amount of memory (sendmail, bind, ntpd and FreeSWAN
VPN),
> but I can't find any more memory modules! I have gotten four or five oops
> the last week or so (in different processes), running 2.2.18. Stepped up
to
> 2.2.19pre7 and hooked up a serial console two days ago, now I got one
again.
>
> [4.] Kernel version (from /proc/version):
> Linux version 2.2.19pre7 (root@r2.runestig.com) (gcc version 2.95.2
19991024
> (release)) #1 Mon Jan 22 11:57:12 CET 2001

OK, following the reiserfs/compiler thread, I can see now that my bug report
may have been ignored since I was using a non-kosher compiler (although I
have used it since late October -99 without any problems). Or, it might not
have been ignored, just nobody told me he/she wasted some time on it. Since
it seems to be hardware related; that oops wasn't the only one, and after
some more strange behaviour, I moved the hard drive to another, almost
identical, PC, with even less memory, 16 MB (but this one I have the chips
to run 48 MB, but I wanted to stress it). And it's been running for a week
now, like a clock.

So, sorry for the false alarm!

Cheers,
Peter
----------------------------------------------------------------
Peter 'Luna' Runestig (fd. Altberg), Sweden <peter@runestig.com>
PGP Key ID: 0xD07BBE13
Fingerprint: 7B5C 1F48 2997 C061 DE4B  42EA CB99 A35C D07B BE13
AOL Instant Messenger Screenname: PRunestig


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
