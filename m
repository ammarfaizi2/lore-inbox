Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWHBEhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWHBEhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWHBEhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:37:10 -0400
Received: from ns1.suse.de ([195.135.220.2]:6276 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751156AbWHBEhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:37:09 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: frequent slab corruption (since a long time)
Date: Wed, 2 Aug 2006 06:35:00 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060802021617.GH22589@redhat.com> <p73fygfzu2v.fsf@verdi.suse.de> <20060802042200.GA30216@redhat.com>
In-Reply-To: <20060802042200.GA30216@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020635.00991.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 06:22, Dave Jones wrote:

> Problem with that approach is that DEBUG_PAGEALLOC makes things
> so damned slow that it's pretty much unusable, and this bug
> doesn't seem to want to repeat itself to order, so I doubt
> many people would put up with the slowdown long enough to chase it down.

Really?  It shouldn't be that much slower in theory. Do you
have numbers?

If it's a big problem it could probably be made faster by batching
the TLB flushes more.

-Andi
