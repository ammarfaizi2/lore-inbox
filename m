Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWHPIIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWHPIIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWHPIIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:08:22 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:31372 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750751AbWHPIIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:08:22 -0400
Date: Wed, 16 Aug 2006 10:08:20 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Diego Calleja <diegocg@gmail.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 2/2] Simple shared page tables
Message-ID: <20060816080820.GA6330@rhlx01.fht-esslingen.de>
References: <20060815225607.17433.32727.sendpatch@wildcat> <20060815225618.17433.84777.sendpatch@wildcat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815225618.17433.84777.sendpatch@wildcat>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 15, 2006 at 05:56:18PM -0500, Dave McCracken wrote:
> +config PTSHARE
> +	bool "Share page tables"
> +	default y
> +	help
> +	  Turn on sharing of page tables between processes for large shared
> +	  memory regions.

A bit too terse IMHO. It could have mentioned (briefly!) that it is able
to save up to several MB of memory, or any other benefits.
Plus, are there drawbacks? (Management overhead, ...)

Andreas Mohr
