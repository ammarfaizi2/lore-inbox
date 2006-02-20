Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWBTAEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWBTAEb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWBTAEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:04:31 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:27581 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932462AbWBTAEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:04:30 -0500
Date: Sun, 19 Feb 2006 16:04:26 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@suse.cz>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Message-ID: <20060220000426.GB5976@us.ibm.com>
References: <20060218231419.GA3219@elf.ucw.cz> <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe> <200602192323.08169.s0348365@sms.ed.ac.uk> <1140391929.2733.430.camel@mindpipe> <20060219234644.GD15608@elf.ucw.cz> <1140393222.2733.438.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140393222.2733.438.camel@mindpipe>
X-Operating-System: Linux 2.6.16-rc4 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2006 [18:53:41 -0500], Lee Revell wrote:
> On Mon, 2006-02-20 at 00:46 +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > I'm still using 1.0.9 on 2.6.16-rc4 with no problems, Audigy 2
> > > > (one that uses emu10k1). 
> > > 
> > > It's a specific change to the SBLive! that did not affect the
> > > Audigy that causes alsa-lib 1.0.10+ to be required on 2.6.14 and
> > > up.  These types of incompatible changes should be rare.
> > 
> > Do you have that patch somewhere handy?
> > 
> 
> Attached
> 
> > How do I tell alsa-lib version?
> > 
> 
> Check your distro's package manager.

Hrm, I didn't mention any alsalib version, because this is what apt told
me:

root@arkanoid:/home/nacc# aptitude search alsa | grep ^i
i   alsa-base                       - ALSA driver configuration files
i   alsa-utils                      - ALSA utilities
root@arkanoid:/home/nacc# aptitude search alsa | grep lib
v   alsalib                         -
v   alsalib0.1.3                    -
v   alsalib0.3.0                    -
v   alsalib0.3.0-dev                -
v   alsalib0.3.2                    -
v   alsalib0.3.2-dev                -

Am I missing something?

Thanks,
Nish
