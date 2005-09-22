Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbVIVAem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVIVAem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 20:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbVIVAem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 20:34:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2272
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965186AbVIVAel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 20:34:41 -0400
Date: Wed, 21 Sep 2005 17:34:08 -0700 (PDT)
Message-Id: <20050921.173408.122945960.davem@davemloft.net>
To: clameter@engr.sgi.com
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables
 performance
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0509211542210.13045@schroedinger.engr.sgi.com>
References: <43308324.70403@cosmosbay.com>
	<4331CFA7.50104@cosmosbay.com>
	<Pine.LNX.4.62.0509211542210.13045@schroedinger.engr.sgi.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <clameter@engr.sgi.com>
Date: Wed, 21 Sep 2005 15:43:29 -0700 (PDT)

> Maybe we better introduce vmalloc_node() instead of improvising this for 
> several subsystems? The e1000 driver has similar issues.

I agree.
