Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030731AbWKORYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030731AbWKORYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030733AbWKORYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:24:55 -0500
Received: from cantor.suse.de ([195.135.220.2]:61851 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030731AbWKORYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:24:54 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] i386-pda UP optimization
Date: Wed, 15 Nov 2006 18:24:35 +0100
User-Agent: KMail/1.9.5
Cc: Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <200611151232.31937.ak@suse.de> <20061115172003.GA20403@elte.hu>
In-Reply-To: <20061115172003.GA20403@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151824.36198.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 18:20, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > On Wednesday 15 November 2006 12:27, Eric Dumazet wrote:
> > > Seeing %gs prefixes used now by i386 port, I recalled seeing strange 
> > > oprofile results on Opteron machines.
> > > 
> > > I really think %gs prefixes can be expensive in some (most ?) cases, 
> > > even if the Intel/AMD docs say they are free.
> > 
> > They aren't free, just very cheap.
> 
> Eric's test shows a 5% slowdown. That's far from cheap.

I have my doubts about the accuracy of his test results. That is why I asked 
him to double check.

-Andi
