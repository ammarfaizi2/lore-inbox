Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279783AbRK2TAp>; Thu, 29 Nov 2001 14:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRK2TAh>; Thu, 29 Nov 2001 14:00:37 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:65208 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S281703AbRK2TAL> convert rfc822-to-8bit;
	Thu, 29 Nov 2001 14:00:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Reply-To: sebastian.droege@gmx.de
To: Dirk Pritsch <dirk@enterprise.in-berlin.de>
Subject: Re: oops with 2.5.1-pre3 in ide-scsi module
Date: Thu, 29 Nov 2001 20:00:36 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011129191938.A1402@Enterprise.in-berlin.de> <200111291838.fATIcHNO029528@einhorn.in-berlin.de> <20011129194556.B1402@Enterprise.in-berlin.de>
In-Reply-To: <20011129194556.B1402@Enterprise.in-berlin.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011129190029Z281703-12472+18@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 29. November 2001 19:45 schrieben Sie:
> Hi,
>
> On Thu, Nov 29, 2001 at 07:38:25PM +0100, Slo Mo Snail wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hi,
> > Have you applied any other patches than the 2.5.1-pre3?
> > If/When not you'll probably get some data corruption :(
> > Please apply the 2 Patches attatched and
> > http://kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre3/b
> >io-pre3-1.gz Then recompile your kernel ;)
> > These patches were posted before by Alan Cox and Jens Axboe
> >
> > CD burning works fine for me with this patches but I have compiled all
> > SCSI and IDE stuff directly into the kernel... maybe this matters
> > Bye
>
> thanks for the info, the patch from Alan was applied, but not the one
>
> >from Jens, I will try it again with both patches.
>
> Cheers,
>
> Dirk
I've forgotten something...
You need first the bio-pre3-1.gz and then the one which was attatched
The first fixes some things in the new block i/o architecture, the 2nd fixes 
the data corruption and fixes some things in the block i/o
Bye
