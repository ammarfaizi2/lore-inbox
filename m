Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751995AbWG1PT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbWG1PT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWG1PT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:19:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27553 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751995AbWG1PT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:19:56 -0400
Date: Fri, 28 Jul 2006 08:19:37 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Pekka J Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: respect architecture and caller mandated alignment
In-Reply-To: <20060728062028.GA9559@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.64.0607280816590.18325@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0607271514310.2172@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0607271909580.15840@schroedinger.engr.sgi.com>
 <20060728062028.GA9559@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006, Heiko Carstens wrote:

> > You may want to document that change somewhere.
> 
> It is already documented (see top of slab.c). The only thing that was 
> wrong was that ARCH_SLAB_MINALIGN and ARCH_KMALLOC_MINALIGN didn't have 
> the effect like one would expect from the documentation.

Some of the passages there are a bit fuzzy to me. This is the first time 
though that we enforce these alignments for the SLAB_DEBUG case.
