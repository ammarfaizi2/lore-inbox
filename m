Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317451AbSFMEkK>; Thu, 13 Jun 2002 00:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317452AbSFMEkJ>; Thu, 13 Jun 2002 00:40:09 -0400
Received: from opus.INS.CWRU.Edu ([129.22.8.2]:49647 "EHLO opus.INS.cwru.edu")
	by vger.kernel.org with ESMTP id <S317451AbSFMEkJ>;
	Thu, 13 Jun 2002 00:40:09 -0400
From: "Braden McGrath" <bwm3@po.cwru.edu>
To: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Kernel 2.4.18 Promise driver (IDE) hangs @ boot with Promise 20267
Date: Thu, 13 Jun 2002 00:42:45 -0400
Message-ID: <000401c21294$c368cbc0$ceaa1681@z>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <007201c2126a$c4abc520$ceaa1681@z>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Braden McGrath
> Sent: Wednesday, June 12, 2002 7:42 PM
> To: linux-kernel@vger.kernel.org
> Subject: Re: PROBLEM: Kernel 2.4.18 Promise driver (IDE) 
> hangs @ boot with Promise 20267

[old message snipped]

> I don't WANT to use the HPT366 anymore, but there
> is NO way to disable it on my motherboard.  Part of me 
> wonders if it is causing a problem, but I don't see any 
> resources being shared...

I've confirmed that my problem in the Promise driver is NOT related to
the HPT366 device.  I swapped the promise card (And the drives attached
to it) to another board, and it hung at the same step in the boot
process - right after finding the drive(s) on the system chipset's
controller, where it should then begin finding stuff on the Promise...
but it can't.

At this point I guess I'm down to waiting.  I don't want to be stuck
using it with the generic driver and thus getting hideous performance.
I've done everything that I know how to do; I'm not much of a coder
(especially not C).   If I thought I could fix it myself I'd try. :)

Hopefully someone becomes my savior before I start looking to *BSD for
an answer... I really don't want to lose all of the data on these drives
(XFS & LVM aren't supported anywhere else) and I have no easy way to
back them up.  That's the biggest thing keeping me on linux at the
moment.

I'll wait patiently now, I know that gurus musn't be pestered. ;)

--Braden

