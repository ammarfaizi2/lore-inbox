Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVIVNFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVIVNFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbVIVNFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:05:13 -0400
Received: from ns.suse.de ([195.135.220.2]:11206 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030300AbVIVNFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:05:10 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Date: Thu, 22 Sep 2005 15:05:04 +0200
User-Agent: KMail/1.8
Cc: Eric Dumazet <dada1@cosmosbay.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
References: <43308324.70403@cosmosbay.com> <200509221454.22923.ak@suse.de> <20050922125849.GA27413@infradead.org>
In-Reply-To: <20050922125849.GA27413@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509221505.05395.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 September 2005 14:58, Christoph Hellwig wrote:

> Umm, no - adding set_fs/get_fs mess for things like that is not right.

I think it's fine. We're using it for various other interfaces too. In fact
sys_set_mempolicy is already used elsewhere in the kernel too.

-Andi
