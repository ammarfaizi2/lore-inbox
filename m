Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135730AbRD2Lc7>; Sun, 29 Apr 2001 07:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135727AbRD2Lcu>; Sun, 29 Apr 2001 07:32:50 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:5380 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135728AbRD2Lcj>;
	Sun, 29 Apr 2001 07:32:39 -0400
Date: Fri, 27 Apr 2001 10:44:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ian Stirling <root@mauve.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lid support.
Message-ID: <20010427104411.A37@(none)>
In-Reply-To: <200104260007.BAA22627@mauve.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200104260007.BAA22627@mauve.demon.co.uk>; from root@mauve.demon.co.uk on Thu, Apr 26, 2001 at 01:07:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I assume there is no generic APM support for lid-close?
> My BIOS (P100 DEC CTS5100 Hinote VP) has no way to do anything other
> than beep, when the lid is closed, so I'm using a hack that polls the
> ct65548 video chips registers to find when the BIOS turns the LCD off,
> so I can do whatever.
> 
> Or is there a better wya?

Yes, going ACPI. But you'll need current acpi, not the one in 2.4.3

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

