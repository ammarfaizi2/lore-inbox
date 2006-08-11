Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWHKVOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWHKVOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWHKVOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:14:10 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:33250 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932083AbWHKVOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:14:08 -0400
Date: Sat, 12 Aug 2006 07:13:14 +1000
From: Anton Blanchard <anton@samba.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
Message-ID: <20060811211314.GF479@krispykreme>
References: <44D99F1A.4080905@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D99F1A.4080905@de.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_phyp.c	1969-12-31 16:00:00.000000000 -0800

> +u64 ehea_h_alloc_resource_eq(const u64 hcp_adapter_handle,
...
> +u64 hipz_h_reregister_pmr(const u64 adapter_handle,
...
> +static inline int hcp_galpas_ctor(struct h_galpas *galpas,

Be nice to have some consistent names, hipz_ and hcp_ is kind of
cryptic.

> +#define H_QP_CR_STATE_RESET	    0x0000010000000000	/*  Reset */

Probably want ULL on here and the other 64bit constants.

Anton
