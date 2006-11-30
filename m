Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759272AbWK3Quh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759272AbWK3Quh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 11:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759275AbWK3Quh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 11:50:37 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:18619 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1759272AbWK3Quh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 11:50:37 -0500
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Wenji Wu <wenji@fnal.gov>, David Miller <davem@davemloft.net>,
       akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061130093329.GA4645@infradead.org>
References: <2f14bf623344.456de60a@fnal.gov>
	 <20061130093329.GA4645@infradead.org>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 11:51:09 -0500
Message-Id: <1164905470.12607.71.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-30 at 09:33 +0000, Christoph Hellwig wrote:
> On Wed, Nov 29, 2006 at 07:56:58PM -0600, Wenji Wu wrote:
> > Yes, when CONFIG_PREEMPT is disabled, the "problem" won't happen. That is why I put "for 2.6 desktop, low-latency desktop" in the uploaded paper. This "problem" happens in the 2.6 Desktop and Low-latency Desktop.
> 
> CONFIG_PREEMPT is only for people that are in for the feeling.  There is no
> real world advtantage to it and we should probably remove it again.

There certainly is a real world advantage for many applications.  Of
course it would be better if the latency requirements could be met
without kernel preemption but that's not the case now.

Lee

