Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161297AbWASJHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161297AbWASJHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161303AbWASJHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:07:21 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:47748 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1161297AbWASJHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:07:20 -0500
Date: Thu, 19 Jan 2006 11:07:09 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@engr.sgi.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [patch 05/10] slab: extract slab_destroy_objs()
In-Reply-To: <Pine.LNX.4.62.0601181030340.1751@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0601191104160.14523@sbz-30.cs.Helsinki.FI>
References: <20060114122249.246354000@localhost> <20060114122418.490182000@localhost>
 <Pine.LNX.4.62.0601181030340.1751@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006, Pekka Enberg wrote:
> > +static void slab_destroy_objs(kmem_cache_t *cachep, struct slab *slabp)
 
On Wed, 18 Jan 2006, Christoph Lameter wrote:
> This is only called once right? Make this inline?

We get better stack traces when its not inlined so I don't see the point.

			Pekka
