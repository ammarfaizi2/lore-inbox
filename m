Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278258AbRJ1McV>; Sun, 28 Oct 2001 07:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278261AbRJ1McC>; Sun, 28 Oct 2001 07:32:02 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:56192 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S278258AbRJ1Mb5>; Sun, 28 Oct 2001 07:31:57 -0500
Message-ID: <00b201c15fac$d633fef0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "David Flynn" <Dave@keston.u-net.com>,
        "linux kernel mailinglist" <linux-kernel@vger.kernel.org>
In-Reply-To: <045301c15fa7$c2809b70$1901a8c0@node0.idium.eu.org>
Subject: Re: Via KT133 and 2.4.8 and a hard disk problem ?
Date: Sun, 28 Oct 2001 13:34:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I often get these kinds of problems with semi-old HD's (UDMA33) when I run
*anything* else than DMA enabled (like when I run stuff like
hdparm -c1 -m16 -u1). It could also be a hard drive reporting the wrong
capabilities to the IDE controller.

A "hdparm /dev/hdX" and "hdparm -I /dev/hdX" would be most helpful to
diagnose your problem.

/Martin (fresh & new to l-k)

----- Original Message -----
From: "David Flynn" <Dave@keston.u-net.com>
To: "linux kernel mailinglist" <linux-kernel@vger.kernel.org>
Sent: Sunday, October 28, 2001 12:57 PM
Subject: Via KT133 and 2.4.8 and a hard disk problem ?


> All;
>
> What is the status of the problems with the old KT133 and kernel 2.4.8 ?
>
> I have a system here which looks to me as if its beginning to suffer from
> HDD failure, just do anything with the disk for a while and you get disk {
> busy } errors (and there is an 0x0d error code there somewhere) ... (oh,
and
> the HDD light reports no activity) normally, i would view this as a good
> time to pull all the data off the drive and replace it.
>
> However, i have noticed that the chipset used is the Via KT133, and am now
> wondering if this is actually a HDD problem (i still am siding with this)
or
> a chipset problem.

<snip>

