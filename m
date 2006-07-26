Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWGZMgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWGZMgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWGZMgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:36:08 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:41937 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751571AbWGZMgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:36:06 -0400
Date: Wed, 26 Jul 2006 15:36:05 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <Pine.LNX.4.58.0607261532130.20519@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.58.0607261535450.20519@sbz-30.cs.Helsinki.FI>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> 
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> 
 <20060722162607.GA10550@osiris.ibm.com>  <84144f020607260422t668c4d8dldfcdedfe3713b73e@mail.gmail.com>
  <Pine.LNX.4.64.0607260426450.3744@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260451250.4021@schroedinger.engr.sgi.com>
 <84144f020607260505s17daa5c8j6e5095eb956828ee@mail.gmail.com>
 <Pine.LNX.4.64.0607260511430.4075@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0607261532130.20519@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Pekka J Enberg wrote:
> My patch changes the code so that, if either architecture or 
> caller mandated alignment is greater than BYTES_PER_WORD, 
> kmem_cache_create will disable debugging. Do you now see why my patch is 
> in fact _not_ ignoring ARCH_KMALLOC_MINALIGN, but instead respecting that.

And btw, I am referring to this patch: http://lkml.org/lkml/2006/7/26/93. 
Not the one I posted initially.

				Pekka
