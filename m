Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWCFWFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWCFWFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWCFWFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:05:35 -0500
Received: from fmr19.intel.com ([134.134.136.18]:54671 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932378AbWCFWFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:05:34 -0500
Message-ID: <440CB22C.6090007@ichips.intel.com>
Date: Mon, 06 Mar 2006 14:05:32 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean Hefty <sean.hefty@intel.com>
CC: "'Roland Dreier'" <rdreier@cisco.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH 2/6] IB: match connection requests based
 on	private data
References: <ORSMSX401FRaqbC8wSA00000005@orsmsx401.amr.corp.intel.com>
In-Reply-To: <ORSMSX401FRaqbC8wSA00000005@orsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hefty wrote:
> +static void cm_mask_compare_data(u8 *dst, u8 *src, u8 *mask)
> +{
> +	int i;
> +
> +	for (i = 0; i < IB_CM_PRIVATE_DATA_COMPARE_SIZE; i++)
> +		dst[i] = src[i] & mask[i];
> +}
> +
> +static int cm_compare_data(struct ib_cm_private_data_compare *src_data,
> +			   struct ib_cm_private_data_compare *dst_data)
> +{
> +	u8 src[IB_CM_PRIVATE_DATA_COMPARE_SIZE];
> +	u8 dst[IB_CM_PRIVATE_DATA_COMPARE_SIZE];

Ugh.  I sent the wrong patch series.  This was the original set of patches, 
before any feedback was incorporated.  I will need to resend patches 2, 4, 5, 
and 6.  Sorry about this.

- Sean
