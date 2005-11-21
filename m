Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVKUQXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVKUQXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVKUQXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:23:10 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:27013 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932372AbVKUQXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:23:09 -0500
Subject: Re: [PATCH] slab: minor cleanup to kmem_cache_alloc_node
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       christoph@lameter.com
In-Reply-To: <4381EE9D.1000506@cosmosbay.com>
References: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI>
	 <4381EE9D.1000506@cosmosbay.com>
Date: Mon, 21 Nov 2005 18:23:06 +0200
Message-Id: <1132590187.8487.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Mon, 2005-11-21 at 16:58 +0100, Eric Dumazet wrote:
> Are you sure this is valid ?
> What about preemption ?
> The "if (nodeid == numa_node_id())" check was done with IRQ off, and you want 
> do do it with IRQ on.

You're right. Please ignore the patch.

			Pekka

