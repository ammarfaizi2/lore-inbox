Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWEPWoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWEPWoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWEPWoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:44:46 -0400
Received: from fmr20.intel.com ([134.134.136.19]:20355 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932256AbWEPWop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:44:45 -0400
Message-ID: <446A55D1.3090100@ichips.intel.com>
Date: Tue, 16 May 2006 15:44:33 -0700
From: Arlin Davis <ardavis@ichips.intel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@pathscale.com>
CC: rdreier@cisco.com, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH 15 of 53] ipath - make some maximum values
 more sane
References: <480ceff18a886d7504a5.1147477380@eng-12.pathscale.com>
In-Reply-To: <480ceff18a886d7504a5.1147477380@eng-12.pathscale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:

>Increase the limits on some maximum values.
>
>  
>
I noticed a rdma/message max size limitation of 4096 the last time I ran 
some dapl tests. Are there plans to increase or did I miss it somewhere 
in all the patches?

Here are the max values returned from the ipath ibv_query_device:

query_hca: (ver=20401) ep 65535 ep_q 65535 evd 65535 evd_q 65535
query_hca: msg 4096 rdma 4096 iov 255 lmr 65535 rmr 0
query_hca:  dto 65535 iov 255 rdma i1,o1

Thanks,

-arlin


