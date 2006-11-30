Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759229AbWK3Jdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759229AbWK3Jdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759232AbWK3Jdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:33:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:65205 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1759229AbWK3Jde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:33:34 -0500
Date: Thu, 30 Nov 2006 09:33:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Wenji Wu <wenji@fnal.gov>
Cc: David Miller <davem@davemloft.net>, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061130093329.GA4645@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Wenji Wu <wenji@fnal.gov>, David Miller <davem@davemloft.net>,
	akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2f14bf623344.456de60a@fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f14bf623344.456de60a@fnal.gov>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 07:56:58PM -0600, Wenji Wu wrote:
> Yes, when CONFIG_PREEMPT is disabled, the "problem" won't happen. That is why I put "for 2.6 desktop, low-latency desktop" in the uploaded paper. This "problem" happens in the 2.6 Desktop and Low-latency Desktop.

CONFIG_PREEMPT is only for people that are in for the feeling.  There is no
real world advtantage to it and we should probably remove it again.

