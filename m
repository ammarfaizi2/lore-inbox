Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVEQH0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVEQH0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVEQH0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:26:33 -0400
Received: from ozlabs.org ([203.10.76.45]:31934 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261301AbVEQH03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:26:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17033.38609.60873.138572@cargo.ozlabs.ibm.com>
Date: Tue, 17 May 2005 17:01:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/8] ppc64: add BPA platform type
In-Reply-To: <200505132125.34358.arnd@arndb.de>
References: <200505132117.37461.arnd@arndb.de>
	<200505132125.34358.arnd@arndb.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> This adds the basic support for running on BPA machines.
> So far, this is only the IBM workstation, and it will
> not run on others without a little more generalization.

> +/* FIXME: consolidate this into rtas.c or similar */
> +static void __init pSeries_calibrate_decr(void)

Shouldn't this be called bpa_calibrate_decr or something similar?

> -#define	PV_630        	0x0040
> -#define	PV_630p	        0x0041
> +#define	PV_630		0x0040
> +#define	PV_630p		0x0041

Hmmm, I don't think your patch needs to clean up the whitespace here.

Regards,
Paul.
