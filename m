Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272216AbTHNFYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 01:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHNFYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 01:24:48 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:61967 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S272216AbTHNFYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 01:24:47 -0400
Date: Thu, 14 Aug 2003 07:24:14 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Martin Sarsale <runa@runa.sytes.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Permedia 2, framebuffer: 2.6.0 test3 doesn't compiles
Message-ID: <20030814052414.GA10568@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030813234332.2c71ebb5.runa@runa.sytes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813234332.2c71ebb5.runa@runa.sytes.net>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Sarsale <runa@runa.sytes.net>
Date: Wed, Aug 13, 2003 at 11:43:32PM -0300
> Dear all: I've just downloaded 2.6.0 test3 and compiled it without framebuffer support and everything worked great.
> 
> Then I wanted to use the vga console, so I added support for permedia 2 framebuffer as module but the kernel doesn't compiles anymore:
> 
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CC [M]  drivers/video/pm2fb.o
> drivers/video/pm2fb.c:44:25: video/fbcon.h: No such file or directory

the permedia driver hasn't been upgraded to the new api in 2.6

Kind regards,
Jurriaan
-- 
Hailing frequencies open Mr. Worf. "Hi, this is Steve Wright on 1 FM."
Debian (Unstable) GNU/Linux 2.6.0-test3-mm1 4276 bogomips load av: 1.04 0.72 0.35
