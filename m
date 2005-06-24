Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263105AbVFXFGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbVFXFGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 01:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVFXFGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 01:06:42 -0400
Received: from graphe.net ([209.204.138.32]:49536 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263100AbVFXFFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 01:05:11 -0400
Date: Thu, 23 Jun 2005 22:05:09 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
       shai@scalex86.org, akpm@osdl.org
Subject: Re: [PATCH] dst numa: Avoid dst counter cacheline bouncing
In-Reply-To: <20050624045854.GA6465@in.ibm.com>
Message-ID: <Pine.LNX.4.62.0506232204320.30382@graphe.net>
References: <Pine.LNX.4.62.0506231953260.28244@graphe.net>
 <Pine.LNX.4.62.0506232005030.28244@graphe.net> <20050624045854.GA6465@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005, Dipankar Sarma wrote:

> Do we really need to do a distributed reference counter implementation
> inside dst cache code ? If you are willing to wait for a while,
> we should have modified Rusty's bigref implementation on top of the 
> interleaving dynamic per-cpu allocator. We can look at distributed 
> reference counter for dst refcount then and see how that can be 
> worked out.

Is that code available somewhere?

