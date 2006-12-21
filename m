Return-Path: <linux-kernel-owner+w=401wt.eu-S1422759AbWLUGOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbWLUGOI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWLUGOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:14:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41565 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422759AbWLUGOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:14:05 -0500
Date: Wed, 20 Dec 2006 22:13:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
Message-Id: <20061220221328.ee3bfc5d.akpm@osdl.org>
In-Reply-To: <200612201313.22572.david-b@pacbell.net>
References: <200611111541.34699.david-b@pacbell.net>
	<200612201304.03912.david-b@pacbell.net>
	<200612201313.22572.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 13:13:21 -0800
David Brownell <david-b@pacbell.net> wrote:

> +#define gpio_get_value(gpio) \
> +	(GPLR & GPIO_GPIO(gpio))
> +
> +#define gpio_set_value(gpio,value) \
> +	((value) ? (GPSR = GPIO_GPIO(gpio)) : (GPCR(gpio) = GPIO_GPIO(gpio)))

likewise.
