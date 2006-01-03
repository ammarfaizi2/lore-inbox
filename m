Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWACV46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWACV46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWACV46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:56:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10769 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932501AbWACV44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:56:56 -0500
Date: Tue, 3 Jan 2006 22:56:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Tomasz Torcz <zdzichu@irc.pl>,
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
Message-ID: <20060103215654.GH3831@stusta.de>
References: <20050726150837.GT3160@stusta.de> <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 09:56:20PM +0100, Jesper Juhl wrote:
> On 1/3/06, Takashi Iwai <tiwai@suse.de> wrote:
> > At Tue, 3 Jan 2006 21:37:32 +0100,
> > Tomasz Torcz wrote:
> > >
> > > On Tue, Jan 03, 2006 at 09:22:58PM +0100, Takashi Iwai wrote:
> > > > At Tue, 3 Jan 2006 18:03:16 +0100,
> > > > Olivier Galibert wrote:
> > > > >
> > > > > > This is exactly why the OSS emulation option in ALSA is really a last resort
> > > > > > and should not be an excuse for people to ignore implementing ALSA support
> > > > > > directly. More so, it is very good justification for ditching "everything
> > > > > > OSS" as soon as possible, at least in new software.
> > > > >
> > > > > Actually the crappy state of OSS emulation is a good reason to ditch
> > > > > ALSA in its current implementation.  As Linus reminded not so long
> > > > > ago, backwards compatibility is extremely important.
> > > >
> > > > Well, we keep the compatibility exactly -- OSS drivers don't support
> > > > software mixing in the kernel, too :)
> > >
> > >  OSS will support software mixing. In kernel. On NetBSD.
> > > http://kerneltrap.org/node/4388
> >
> > Why do we need to keep the compatibility with NetBSD?
> >
> Software mixing is a really nice feature for people with soundscards
> that can't do hardware mixing, so if the OSS compatibility could
> transparently do software mixing for apps using OSS api that would be
> a very nice extension for a lot of people - I'd say that if NetBSD do
> that they've got the right idea.

The OSS compatibility in ALSA is only a legacy API for applications not 
yet converted to use the ALSA API.

> Jesper Juhl

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

