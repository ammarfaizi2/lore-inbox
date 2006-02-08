Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbWBHDsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbWBHDsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbWBHDsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:48:50 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:53431 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030500AbWBHDst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:48:49 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] [PATCH] mm: implement swap prefetching v21
Date: Wed, 8 Feb 2006 14:49:20 +1100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
References: <200602071028.30721.kernel@kolivas.org> <20060206163842.7ff70c49.akpm@osdl.org> <200602081429.11823.kernel@kolivas.org>
In-Reply-To: <200602081429.11823.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081449.20767.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006 02:29 pm, Con Kolivas wrote:
> Ok here is a rewrite incorporating many of the suggested changes by Andrew
> and Nick (thanks both for comments). The numa and cpuset issues Nick
> brought up I have not tackled (yet?)

> +/* sysctl - enable/disable swap prefetching */
> +int swap_prefetch __read_mostly = 1;

Err I seem to have forgotten to actually use the enable/disable tunable now. 
Patch works fine otherwise.

Cheers,
Con
