Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWADBBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWADBBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWADBBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:01:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43026 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751522AbWADBBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:01:30 -0500
Date: Wed, 4 Jan 2006 02:01:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Takashi Iwai <tiwai@suse.de>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060104010123.GK3831@stusta.de>
References: <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl> <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl> <20060104000344.GJ3831@stusta.de> <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 01:46:08AM +0100, Tomasz K?oczko wrote:
> On Wed, 4 Jan 2006, Adrian Bunk wrote:
> [..]
> >>Solaris, AIX ..
> >>Full list is avalaible in "Operating System" listbox on
> >>http://www.4front-tech.com/download.cgi
> >
> >As I said in footnote 1 of my email, this has little value for
> >application developers since only few users on these systems use this
> >commercial sound system.
> 
> You are wrong using pejorative labeling "commercial sound system" for 
> this. Comercial is implementation. OSS is defined by user space API.
> This is all what was neccessary on implemting this in for Linux.

The question is simple:

How many percent of the Solaris or AIX users are actually using any 
sound system implementing the OSS API?

> OSS case on Linux is very simillar to Motiff case on X11.
> As same as Motiff OSS have publically avalaible and open specyfication
> avalaible on http://www.opensound.com/pguide/oss.pdf which do not touch 
> kernel level implemntations details. Using this specyfication you can
> collect all neccessary details for implemt handle /dev/* interface on
> kernel side.

There are many cross-platform audio libraries available that work on 
more systems than the systems implementing the OSS API (because they 
have backends for many different sound APIs including OSS), and many of 
them are with open specifications.

> kloczek

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

