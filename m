Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263052AbVAFV7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbVAFV7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVAFV7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:59:05 -0500
Received: from quark.didntduck.org ([69.55.226.66]:27610 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S263052AbVAFV5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:57:31 -0500
Message-ID: <41DDB465.8000705@didntduck.org>
Date: Thu, 06 Jan 2005 16:57:57 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get
References: <20050106213225.GJ6184@hygelac>
In-Reply-To: <20050106213225.GJ6184@hygelac>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:
> Hello,
> 
> we've noticed that in recent 2.6.10 kernels that the inter_module_
> routines (such as inter_module_get) are marked deprecated. it appears
> that the __symbol_ routines (such as __symbol_get) are intended as the
> replacement routines.
> 
> unfortunately, __symbol_get is only exported as a GPL symbol (I see a
> reference to a _gpl verion in module.h, but no definition). is this
> intentional? will there be a non-gpled version of an equivalent
> routine?
> 
> Thanks,
> Terence

I believe there is an AGP/DRM rewrite in progress that should eliminate 
the need to use inter_module or symbol_get stuff.

--
				Brian Gerst
