Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWARSbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWARSbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWARSbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:31:36 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:899 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030246AbWARSbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:31:35 -0500
Date: Wed, 18 Jan 2006 10:31:11 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [patch 05/10] slab: extract slab_destroy_objs()
In-Reply-To: <20060114122418.490182000@localhost>
Message-ID: <Pine.LNX.4.62.0601181030340.1751@schroedinger.engr.sgi.com>
References: <20060114122249.246354000@localhost> <20060114122418.490182000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006, Pekka Enberg wrote:

> +static void slab_destroy_objs(kmem_cache_t *cachep, struct slab *slabp)

This is only called once right? Make this inline?
