Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263161AbVAFWye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbVAFWye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbVAFWyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:54:06 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:5165 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S263161AbVAFWvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:51:42 -0500
Date: Thu, 6 Jan 2005 16:51:40 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get
Message-ID: <20050106225140.GO6184@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20050106213225.GJ6184@hygelac> <41DDB465.8000705@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DDB465.8000705@didntduck.org>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 06 Jan 2005 22:51:41.0430 (UTC) FILETIME=[49ACD960:01C4F442]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


we currently use inter_module_get_request to make sure the agpgart
module is loaded when we initialize. does this mean we would no longer
need to make sure agpgart is loaded, or that it would always be
loaded?

Thanks,
Terence

On Thu, Jan 06, 2005 at 04:57:57PM -0500, bgerst@didntduck.org wrote:
> I believe there is an AGP/DRM rewrite in progress that should eliminate 
> the need to use inter_module or symbol_get stuff.
> 
> --
> 				Brian Gerst
