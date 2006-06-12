Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751956AbWFLOm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbWFLOm4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbWFLOm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:42:56 -0400
Received: from mail.gmx.de ([213.165.64.20]:29624 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751956AbWFLOm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:42:56 -0400
X-Flags: 0001
Date: Mon, 12 Jun 2006 16:42:54 +0200
Message-ID: <20060612144254.305930@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Cc: alsa-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       rlrevell@joe-job.com
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5hbqsyd4uz.wl%tiwai@suse.de>
References: <20060610082223.321730@gmx.net> <s5hbqsyd4uz.wl%tiwai@suse.de>
Subject: Re: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and
 ALSA?
To: Takashi Iwai <tiwai@suse.de>
X-Authenticated: #6097454
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -------- Original-Nachricht --------
> Datum: Mon, 12 Jun 2006 12:51:16 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Betreff: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and
> ALSA?
> 
> > Well, implementing the dma_mmap_coherent() function isn't the
> > problem, because it is already implemented for the ARM
> > architecture.
> 
> Actually, I wrote dma_coherent_mmap patch long time ago but it has
> been left forgotten.  The patch attached below seems applicable to
> 2.6.17 tree, but I'm not sure whether it still works properly.
> It's untested on most of architectures.

Thanks, that helps me a lot!

> > But as far as I understand this would require a rewrite of all the
> > ALSA drivers (or at least a rewrite of the ALSA's DMA helper
> > functions).
> 
> Yes.  The change of ALSA side has been also on my tree.  But it was
> still pending since I'm not satisfied with the design yet.
> If you're interested in it, let me know.  I'll post the patch.

Yes, please! Then I can test, if the dma_mmap_coherent() patch works on
my non cache coherent powerpc machine. Do you think the DMA Layer/ALSA patches will go upstream in one of the next ALSA/Linux kernel versions?

Thanks!

Gerhard

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
