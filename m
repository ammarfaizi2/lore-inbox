Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283499AbRK3DqG>; Thu, 29 Nov 2001 22:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283497AbRK3Dp4>; Thu, 29 Nov 2001 22:45:56 -0500
Received: from codepoet.org ([166.70.14.212]:28179 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S283496AbRK3Dpl>;
	Thu, 29 Nov 2001 22:45:41 -0500
Date: Thu, 29 Nov 2001 20:45:43 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-via@gtf.org
Subject: Re: via82cxxx_audio doesn't play audio?
Message-ID: <20011129204543.A4717@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-via@gtf.org
In-Reply-To: <20011129190617.A3975@codepoet.org> <3C06F125.A1D3EBD3@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C06F125.A1D3EBD3@mandrakesoft.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.13-ac8-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Nov 29, 2001 at 09:38:29PM -0500, Jeff Garzik wrote:
> Erik Andersen wrote:
> > 
> > I went out the other day and bought an Athlon to replace my aging
> > celeron 400.  I installed an Epox EP-8KHA+ with an Athlon XP 1600+.
> > The VIA 8233 Southbridge on the motherboard has builtin audio
[---------snip--------]
> > 
> > When I go to play audio, no sound is produced.  The mixer works.
[---------snip--------]
> 
> You need ALSA drivers.
> 
> Via 686 audio is different from Via 8233 audio, and you have the
> latter.  The PCI ids were added to via82cxxx_audio, but they need to be
> removed since they apparently do not work (contrary to one report I
> received).

Thanks.  The ALSA drivers indeed work just great.  So yeah, do
pull the Via 8233 audio PCI IDs from via82cxxx_audio.  ALSA seems
to be the One True Path for these monsters.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
