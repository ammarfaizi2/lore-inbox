Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWGDQl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWGDQl2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWGDQl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:41:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60365 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932276AbWGDQl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:41:27 -0400
Date: Tue, 4 Jul 2006 09:41:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
In-Reply-To: <1152030220.3109.73.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0607040940110.14152@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
  <20060704120242.GA3386@infradead.org>  <Pine.LNX.4.64.0607040806580.13456@schroedinger.engr.sgi.com>
  <200607041723.46604.ak@suse.de>  <Pine.LNX.4.64.0607040915420.13795@schroedinger.engr.sgi.com>
 <1152030220.3109.73.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006, Arjan van de Ven wrote:

> >  will need to have highmem? I guess the 2G/2G 
> > config option changes that?
> 
> but that breaks userspace ABI and things that really want a lot of
> memory ;)

Really? What things does it break? Sorry about my i386 ignorance.

> Thankfully x86-64 is there, and just about all systems sold today do 64
> bit.. 

Right but then some binary stuff is only available for 32 bit.
