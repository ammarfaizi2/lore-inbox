Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVH0MsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVH0MsD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 08:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbVH0MsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 08:48:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11783 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750794AbVH0MsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 08:48:01 -0400
Date: Sat, 27 Aug 2005 14:47:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jerome Pinot <ngc891@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [KCONFIG] Can't compile 2.6.12 without Gettext
Message-ID: <20050827124751.GK6471@stusta.de>
References: <88ee31b705082421303697aef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ee31b705082421303697aef7@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 01:30:41PM +0900, Jerome Pinot wrote:

> Hi,

Hi Jerome,

> I didn't see much informations about this.
> 
> It's not possible to "make {,menu}config" and even to compile a 2.6.12
> kernel if there is no or partially installed Gettext on the system.
> 
> Full Gettext is *required* to launch the kbuild scripts since the
> modifications to add i18n to the config scripts.
> 
> Not all system have gettext, I'm thinking about small or embedded
> system with specific toolchain. For example, uClibc is widely used but
> as still a partial nls support.
> 
> Anyway, this should not be required for compiling a kernel. At least
> an option to pass to make which override the default behavior could
> solve the issue.
> 
> Moreover, the script doesn't do any sanity check about the system
> (there is no configure script of course) and just try to catch the
> gettext binaries he founds first. There is a hard-coded filename too.
> 
> Seems dangerous to me and should not be allowed by default.
> 
> Am I misleading ?

are you using an ftp.kernel.org 2.6.12 kernel or a vendor kernel?

If it's an ftp.kernel.org kernel, please send the exact error messages 
you are seeing.

> Jerome Pinot

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

