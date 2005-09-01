Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVIAIxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVIAIxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 04:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVIAIxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 04:53:21 -0400
Received: from isilmar.linta.de ([213.239.214.66]:42894 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750742AbVIAIxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 04:53:21 -0400
Date: Thu, 1 Sep 2005 10:53:19 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Dan Malek <dan@embeddededge.com>, Pantelis Antoniou <panto@intracom.gr>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
Message-ID: <20050901085319.GB6285@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	linux-kernel@vger.kernel.org,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Dan Malek <dan@embeddededge.com>,
	Pantelis Antoniou <panto@intracom.gr>
References: <20050830024840.GA5381@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830024840.GA5381@dmt.cnet>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 29, 2005 at 11:48:40PM -0300, Marcelo Tosatti wrote:
> Russell: The driver is using pccard_nonstatic_ops for card window
> management, even though the driver its marked SS_STATIC_MAP (using
> mem->static_map).

This is obviously broken. Where does it fail if pccard_static_ops is used?

> +typedef struct  {
> +	u_int regbit;
> +	u_int eventbit;
> +} event_table_t;

No typedefs, please.

	Dominik
