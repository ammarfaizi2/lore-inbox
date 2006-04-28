Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWD1Mtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWD1Mtr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 08:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWD1Mtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 08:49:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17063 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030373AbWD1Mtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 08:49:46 -0400
Message-ID: <44520F54.7010209@sgi.com>
Date: Fri, 28 Apr 2006 14:49:24 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060223)
MIME-Version: 1.0
To: Dean Nelson <dcn@sgi.com>
CC: akpm@osdl.org, tony.luck@intel.com, avolkov@varma-el.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       paulus@samba.org, holt@sgi.com
Subject: Re: [PATCH] change gen_pool allocator to not touch managed memory
References: <444D1A7E.mailx85W11DZZU@aqua.americas.sgi.com> <20060424181626.09966912.akpm@osdl.org> <20060425155051.GA19248@sgi.com> <444F3990.5030100@sgi.com> <20060426132803.GA30360@sgi.com> <444F78AB.6030803@sgi.com> <20060426163151.GA8037@sgi.com>
In-Reply-To: <20060426163151.GA8037@sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean Nelson wrote:
> The following patch modifies the gen_pool allocator (lib/genalloc.c) to
> utilize a bitmap scheme instead of the buddy scheme. The purpose of this
> change is to eliminate the touching of the actual memory being allocated.
> 
> Since the change modifies the interface, a change to the uncached
> allocator (arch/ia64/kernel/uncached.c) is also required.
> 
> Signed-off-by: Dean Nelson <dcn@sgi.com>

Acked-by: Jes Sorensen <jes@sgi.com>

Jes
