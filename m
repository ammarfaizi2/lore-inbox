Return-Path: <linux-kernel-owner+w=401wt.eu-S965138AbXAEJaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbXAEJaV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 04:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbXAEJaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 04:30:20 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:51061 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965139AbXAEJaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 04:30:18 -0500
Date: Fri, 5 Jan 2007 10:30:13 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Kars de Jong <jongk@linux-m68k.org>, linux-scsi@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [RFC: 2.6 patch] remove the broken SCSI_AMIGA7XX driver
In-Reply-To: <20070104185359.GJ20714@stusta.de>
Message-ID: <Pine.LNX.4.62.0701051026500.17589@pademelon.sonytel.be>
References: <20070104185359.GJ20714@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Adrian Bunk wrote:
> The SCSI_AMIGA7XX driver:
> - has been marked as BROKEN for more than two years and
> - is still marked as BROKEN.
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.

There's a fix available to convert this driver to the new 53c700 core.
But it needs the new DMA framework, which still causes a few regressions on
m68k that are being worked on.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
