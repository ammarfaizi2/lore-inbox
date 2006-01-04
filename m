Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWADNVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWADNVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 08:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWADNVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 08:21:44 -0500
Received: from csl2r.consultronics.on.ca ([204.138.93.16]:9093 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S1751785AbWADNVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 08:21:43 -0500
Date: Wed, 4 Jan 2006 08:21:39 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060104132139.GA5753@athame.dynamicro.on.ca>
Mail-Followup-To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl> <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl> <20060104000344.GJ3831@stusta.de> <Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl> <20060104010123.GK3831@stusta.de> <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl> <1136364634.22598.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1136364634.22598.70.camel@localhost.localdomain>
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20060104 (Wed) at 0850:34 +0000, Alan Cox wrote:
> On Mer, 2006-01-04 at 03:51 +0100, Tomasz K??oczko wrote:
> > Be compliant with OSS specyfication allow save many time on applications 
> > development level by consume (in good sense) time spend on this 
> > applications by *BSD, Solaris and other systems developers (even on not 
> > open source applications).
> 
> Both Solaris and FreeBSD contain Linux emulation code so in that sense
> they admitted 'defeat' long ago.
> 
> > valuable functionalities in usable/simpler form for joe-like users .. 
> > remember: sound support in Linux isn't for data centers/big-ass-machines :)
> 
> And distributions nowdays ship with ALSA by default, which is giving
> users far better audio timing behaviour, mixing they want, digital and
> analogue 5.1 outputs. OSS really isn't ideal for serious "end user"
> applications like video playback
> 
Ok, so I'm not serious :) just wanna do fairly standard audio things.

- ALSA doesn't (AFAIK, haven't checked for a few months) support my old
  Audiotrix sound card -- bye, machine 1
- ALSA can't be persuaded (not by me, anyway) to drive my VIA
  ac97_codec onboard sound hardware -- everything works fine except
  unmuting ;) -- bye, machine 2
- ALSA does suport my i810_audio ac97_codec laptop, but so does OSS,
  equally well (for my unsophisticated needs) and with a far less
  elephantine footprint in memory. -- strike 3, ALSA out.

So even if sound support in Linux _is_ for "big-ass" studio work, it
would be nice if little guys didn't get abandoned along the way, IMHO.

-- 
| G r e g  L o u i s         | gpg public key: 0x400B1AA86D9E3E64 |
|  http://www.bgl.nu/~glouis |   (on my website or any keyserver) |
|  http://wecanstopspam.org in signatures helps fight junk email. |
