Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751882AbWFWSVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbWFWSVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWFWSVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:21:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751882AbWFWSVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:21:15 -0400
Date: Fri, 23 Jun 2006 11:20:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Bligh <mbligh@google.com>
cc: Christoph Lameter <clameter@sgi.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
In-Reply-To: <449C2EC2.8050602@google.com>
Message-ID: <Pine.LNX.4.64.0606231119240.6483@g5.osdl.org>
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com> 
 <1151019590.15744.144.camel@lappy>  <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>
  <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com> 
 <Pine.LNX.4.64.0606230955230.6265@schroedinger.engr.sgi.com>
 <1151083338.30819.28.camel@lappy> <Pine.LNX.4.64.0606231048020.6519@schroedinger.engr.sgi.com>
 <449C2EC2.8050602@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jun 2006, Martin Bligh wrote:
> 
> I had assumed this was a sick joke. Please tell me people aren't
> really swapping over NFS. That's *insane*.

Hey, I think it even used to be common. I think some NCR X client did 
basically exactly that, with _no_ local disk at all.

			Linus
