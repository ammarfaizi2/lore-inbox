Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbVIVBpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbVIVBpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 21:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVIVBpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 21:45:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3722 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965205AbVIVBpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 21:45:18 -0400
Date: Wed, 21 Sep 2005 18:44:51 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "David S. Miller" <davem@davemloft.net>
cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
In-Reply-To: <20050921.173408.122945960.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0509211843530.13764@schroedinger.engr.sgi.com>
References: <43308324.70403@cosmosbay.com> <4331CFA7.50104@cosmosbay.com>
 <Pine.LNX.4.62.0509211542210.13045@schroedinger.engr.sgi.com>
 <20050921.173408.122945960.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, David S. Miller wrote:

> From: Christoph Lameter <clameter@engr.sgi.com>
> Date: Wed, 21 Sep 2005 15:43:29 -0700 (PDT)
> 
> > Maybe we better introduce vmalloc_node() instead of improvising this for 
> > several subsystems? The e1000 driver has similar issues.
> 
> I agree.

I did an implementation in June.

See http://marc.theaimsgroup.com/?l=linux-mm&m=111766643127530&w=2

Not sure if this will fit the bill. Never really tested it.

