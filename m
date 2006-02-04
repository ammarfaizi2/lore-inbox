Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946001AbWBDJTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946001AbWBDJTy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946000AbWBDJTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:19:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11156 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1945997AbWBDJTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:19:53 -0500
Date: Sat, 4 Feb 2006 09:19:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, acme@conectiva.com.br,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] move some code to net/ipx/af_ipx.c
Message-ID: <20060204091942.GA19863@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	acme@conectiva.com.br, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20060204010958.GY4408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204010958.GY4408@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 02:09:59AM +0100, Adrian Bunk wrote:
> This patch moves some code only used in this file to net/ipx/af_ipx.c .

this doesn't make any sense.  the code is part of the 802.2/3 layer, not the
ipx layer even if no other protocol makes use of it yet.

