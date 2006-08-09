Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWHINQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWHINQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWHINQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:16:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:55237 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750747AbWHINQF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:16:05 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/6] ehea: pHYP interface
Date: Wed, 9 Aug 2006 15:14:46 +0200
User-Agent: KMail/1.9.1
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       Thomas Klein <tklein@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
References: <44D99F1A.4080905@de.ibm.com>
In-Reply-To: <44D99F1A.4080905@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608091514.46861.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 10:38, Jan-Bernd Themann wrote:
> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_hcall.h 1969-12-31 16:00:00.000000000 -0800
> +++ kernel/drivers/net/ehea/ehea_hcall.h        2006-08-08 23:59:38.111462960 -0700
> @@ -0,0 +1,52 @@

> +
> +/**
> + * This file contains HCALL defines that are to be included in the appropriate
> + * kernel files later
> + */
> +
> +#define H_ALLOC_HEA_RESOURCE   0x278
> +#define H_MODIFY_HEA_QP        0x250
> +#define H_QUERY_HEA_QP         0x254
> +#define H_QUERY_HEA            0x258
> +#define H_QUERY_HEA_PORT       0x25C
> +#define H_MODIFY_HEA_PORT      0x260
> +#define H_REG_BCMC             0x264
> +#define H_DEREG_BCMC           0x268
> +#define H_REGISTER_HEA_RPAGES  0x26C
> +#define H_DISABLE_AND_GET_HEA  0x270
> +#define H_GET_HEA_INFO         0x274
> +#define H_ADD_CONN             0x284
> +#define H_DEL_CONN             0x288

I  guess these should go to include/asm-powerpc/hvcall.h instead.

	Arnd <><
