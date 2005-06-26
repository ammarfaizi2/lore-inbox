Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVFZI2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVFZI2F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 04:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVFZI2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 04:28:05 -0400
Received: from witte.sonytel.be ([80.88.33.193]:24770 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261534AbVFZIZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 04:25:39 -0400
Date: Sun, 26 Jun 2005 10:25:33 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Chris Zankel <chris@zankel.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xtensa: Architecture support for Tensilica Xtensa Part
 1
In-Reply-To: <200506241705.j5OH5FmU000463@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0506261024400.16249@numbat.sonytel.be>
References: <200506241705.j5OH5FmU000463@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005, Linux Kernel Mailing List wrote:
> new file mode 100644
> --- /dev/null
> +++ b/arch/xtensa/Kconfig

    [...]

> +config GENERIC_CALIBRATE_DELAY
> +	bool "Auto calibration of the BogoMIPS value"
> +	---help---
> +	  The BogoMIPS value can easily derived from the CPU frequency.
                             ^^^^^^^^^^^^^^^^^^
missing `be'

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
