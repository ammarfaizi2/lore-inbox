Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281017AbRKTQYg>; Tue, 20 Nov 2001 11:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281159AbRKTQY0>; Tue, 20 Nov 2001 11:24:26 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:60071 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S281017AbRKTQYM>; Tue, 20 Nov 2001 11:24:12 -0500
Message-Id: <200111201624.fAKGO7E28238@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: "Paul G. Allen" <pgallen@randomlogic.com>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon: Kernel 2.4.14 IDE problems
Date: Tue, 20 Nov 2001 11:23:55 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3BFA4F69.D7560BDE@randomlogic.com>
In-Reply-To: <3BFA4F69.D7560BDE@randomlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We use 20 GB Western Digitals on our dual Athlons.  The chipset does 
support DMA and it has been quite stable.  Therefore, I would direct blame 
toward the drive.

	-- Brian

On Tuesday 20 November 2001 07:41 am, Paul G. Allen wrote:
> I just compiled and installed a vanilla 2.4.14 kernel (nope, I haven't
> tweaked this one yet :). Just as a reminder, I have a Tyan Thunder K7
> with 2 1.4GHz Athlons (_NOT_ MP or XP). It has an IBM DTLA-307030
> Ultra100 IDE drive on the Ultra100 IDE interface.
>
> The kernel seems to boot with DMA enabled for this drive which causes
> frequent system lockups. This is the same problem I had with kernels
> through 2.4.9 (including the ac series). Disabling DMA (hdparm -d0
> /dev/hda) solves the problem.
>
> Is this a hardware issue with the MP chipset (I have not kept up to date
> on AMD errata due to other projects), or is this drive one of the known
> IDE drives that do not properly support DMA? If a chipset issue, should
> the kernel not detect the problem and disable DMA?
>
> PGA
