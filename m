Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUGXUcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUGXUcL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 16:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUGXUcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 16:32:11 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:62860 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S262730AbUGXUcK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 16:32:10 -0400
Subject: Re: Problem with snd_atiixp in 2.6.8-rc2 (and a workaround)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Osterlund <petero2@telia.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <m3hdrx6w0p.fsf@telia.com>
References: <m37jsv3j6a.fsf@telia.com>  <m3hdrx6w0p.fsf@telia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1090701125.7455.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 16:32:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 24/07/2004 klokka 15:32, skreiv Peter Osterlund:
> Peter Osterlund <petero2@telia.com> writes:
> 
> > The snd_atiixp module in the 2.6.8-rc2 kernel doesn't work on my
> > Compaq Presario R3000 (R3057EA) computer. When I load the module,
> > the kernel reports:
> > 
> > ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 5 (level, low) -> IRQ 5
> > ATI IXP AC97 controller: probe of 0000:00:14.5 failed with error -13
> 
> I see that this problem has already been fixed in the ALSA CVS, so
> sorry for the noise, and thanks for the fix.

It still needs to be fixed in the kernel itself. This bug and the fix
were both reported during the 2.6.6 cycle: we're now in 2.6.8-rc2...

Why the delay on such a trivial bug?

Trond
