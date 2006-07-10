Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWGJN5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWGJN5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWGJN5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:57:05 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57094 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964864AbWGJN5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:57:04 -0400
Date: Mon, 10 Jul 2006 15:57:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Adam =?utf-8?Q?Tla=C5=82ka?= <atlka@pg.gda.pl>
Cc: Lee Revell <rlrevell@joe-job.com>, alan@lxorguk.ukuu.org.uk,
       alsa-devel@alsa-project.org, ak@suse.de, perex@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
Message-ID: <20060710135702.GZ13938@stusta.de>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe> <20060710132810.551a4a8d.atlka@pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060710132810.551a4a8d.atlka@pg.gda.pl>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 01:28:10PM +0200, Adam Tlałka wrote:
> On Sun, 09 Jul 2006 11:18:19 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Sat, 2006-07-08 at 01:50 +0200, Andi Kleen wrote:
> > > Adrian Bunk <bunk@stusta.de> writes:
> > > > 
> > > > Q: What about the OSS emulation in ALSA?
> > > > A: The OSS emulation in ALSA is not affected by my patches
> > > >    (and it's not in any way scheduled for removal).
> > > 
> > > I again object to removing the old ICH sound driver.
> > > It does the same as the Alsa driver in much less code and is ideal
> > > for generic monolithic kernels
> > 
> > It doesn't do the same thing - software mixing is impossible with OSS.
> 
> Only GPL'ed version has this limitation - its just not implemented because all this
> GPL'ed OSS is abandoned.
> The commercial version from www.opensound.com does input/output mixing
> in software in kernel space.
>...

When we are talking about OSS, we are talking about what is under 
sound/oss/ in the kernel sources.

The commercial OSS might be much better, but it's not relevant since 
it's not GPL'ed and therefore not a candidate for inclusion into the 
kernel.

As you said yourself, the "GPL'ed OSS is abandoned".
And ALSA is it's successor in the kernel.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

