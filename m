Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWHNNxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWHNNxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 09:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWHNNxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 09:53:22 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:22773 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751467AbWHNNxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 09:53:21 -0400
Message-ID: <44E07732.4010508@de.ibm.com>
Date: Mon, 14 Aug 2006 15:14:26 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
References: <44D99F1A.4080905@de.ibm.com> <20060811211314.GF479@krispykreme>
In-Reply-To: <20060811211314.GF479@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Anton Blanchard wrote:
 > Hi,
 >
 >> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_phyp.c       1969-12-31 16:00:00.000000000 -0800
 >
 >> +u64 ehea_h_alloc_resource_eq(const u64 hcp_adapter_handle,
 > ...
 >> +u64 hipz_h_reregister_pmr(const u64 adapter_handle,
 > ...
 >> +static inline int hcp_galpas_ctor(struct h_galpas *galpas,
 >
 > Be nice to have some consistent names, hipz_ and hcp_ is kind of
 > cryptic.

We choose some more meaningful names and added comments to explain those.

 >
 >> +#define H_QP_CR_STATE_RESET     0x0000010000000000  /*  Reset */
 >
 > Probably want ULL on here and the other 64bit constants.
 >

ULL added

 > Anton

Jan-Bernd
