Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTJ0OqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 09:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263255AbTJ0OqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 09:46:09 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:23982 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263229AbTJ0OqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 09:46:07 -0500
Subject: Re: [PATCH] USB: add W996[87]CF driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Luca Risolia <luca_ing@libero.it>, marcelo@cyclades.de
In-Reply-To: <200310252102.h9PL2H6C018450@hera.kernel.org>
References: <200310252102.h9PL2H6C018450@hera.kernel.org>
Content-Type: text/plain
Message-Id: <1067265963.15551.373.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Mon, 27 Oct 2003 14:46:03 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-08 at 19:04 +0000, Linux Kernel Mailing List wrote:
> +/* URB error codes: */
> +static struct w9968cf_symbolic_list urb_errlist[] = {
> +	{ -ENOMEM,    "No memory for allocation of internal structures" },
> +	{ -ENOSPC,    "The host controller's bandwidth is already consumed" },
> +	{ -ENOENT,    "URB was canceled by unlink_urb" },
> +	{ -EXDEV,     "ISO transfer only partially completed" },
> +	{ -EAGAIN,    "Too match scheduled for the future" },
> +	{ -ENXIO,     "URB already queued" },
> +	{ -EFBIG,     "Too much ISO frames requested" },
> +	{ -ENOSR,     "Buffer error (overrun)" },
> +	{ -EPIPE,     "Specified endpoint is stalled (device not responding)"},
> +	{ -EOVERFLOW, "Babble (bad cable?)" },
> +	{ -EPROTO,    "Bit-stuff error (bad cable?)" },
> +	{ -EILSEQ,    "CRC/Timeout" },
> +	{ -ETIMEDOUT, "NAK (device does not respond)" },
> +	{ -1, NULL }
> +};

Urgh. Do we have to?

-- 
dwmw2

