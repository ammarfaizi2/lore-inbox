Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751860AbWFWSLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbWFWSLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWFWSLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:11:41 -0400
Received: from smtp-out.google.com ([216.239.45.12]:59110 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751860AbWFWSLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:11:41 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=q2Q5Y7Hysj7Gcrmu4Ze3ayxthPeUrKJ+1TmzYOayEfhMjmHDapz/FFM9FCnwkPcZW
	wdmZ87t5LPfFNXwuf0mCA==
Message-ID: <449C2EC2.8050602@google.com>
Date: Fri, 23 Jun 2006 11:11:14 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
References: <20060619175243.24655.76005.sendpatchset@lappy>  <20060619175253.24655.96323.sendpatchset@lappy>  <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>  <1151019590.15744.144.camel@lappy>  <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>  <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com>  <Pine.LNX.4.64.0606230955230.6265@schroedinger.engr.sgi.com> <1151083338.30819.28.camel@lappy> <Pine.LNX.4.64.0606231048020.6519@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606231048020.6519@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>I intent to make swap over NFS work next.
> 
> 
> I am still a bit unclear on what you mean by "work." The only 
> issue may be to consider the amount of swap pages about to be written out 
> for write throttling.

I had assumed this was a sick joke. Please tell me people aren't
really swapping over NFS. That's *insane*.

M.
