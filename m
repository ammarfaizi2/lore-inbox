Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316928AbSFDW1n>; Tue, 4 Jun 2002 18:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316933AbSFDW1m>; Tue, 4 Jun 2002 18:27:42 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:3774 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316928AbSFDW1l>; Tue, 4 Jun 2002 18:27:41 -0400
Date: Wed, 5 Jun 2002 00:27:43 +0200
From: Jan Hudec <bulb@ucw.cz>
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
Message-ID: <20020604222743.GA15714@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020604193806.58478.qmail@web14905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 03:38:06PM -0400, Michael Zhu wrote:
> Hi, I built a kernel module. I can load it into the
> kernle using insmod command. But each time when I
> reboot my computer I couldn't find it any more. I mean
> I need to use the insmod to load the module each time
> I reboot the computer. How can I modify the
> configuration so that the Linux OS can load my module
> automatically during reboot? I need to copy my module
> to the following directory?
>   /lib/modules/2.4.7-10/

Kernel does not seek for modules to load in any way. Actually, in usual
installation there are tons of modules compiled an mostly unused. You
must put the insmod command (or better modprobe command) somewhere in
the init scripts. Since I expect your installation is RedHat (the kernel
version looks like a RedHat one), there should already be one a it
should be loading all modules listed in /etc/modules.conf (not sure abou
the exact name - I don't have RedHat).

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
