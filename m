Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282494AbRLDRkp>; Tue, 4 Dec 2001 12:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281153AbRLDRjN>; Tue, 4 Dec 2001 12:39:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5893 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281624AbRLDRhy>; Tue, 4 Dec 2001 12:37:54 -0500
Subject: Re: [s-h] Re: OSS driver cleanups.
To: tiwai@suse.de (Takashi Iwai)
Date: Tue, 4 Dec 2001 17:42:21 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        lk@tantalophile.demon.co.uk (Jamie Lokier),
        zwane@linux.realnet.co.sz (Zwane Mwaikambo),
        linux-kernel@vger.kernel.org (Linux Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <s5hy9kinbaw.wl@alsa1.suse.de> from "Takashi Iwai" at Dec 04, 2001 06:29:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BJaH-0002nZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As long as using only ALSA native applications, "modprobe xxx" would
> be enough.  The subtle configuration is required for OSS emulation,
> kmod support and card-specific module options.

That should be fixable. Trying to open oss emulation devices can load the
OSS emulation.

Alan
