Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWGKVaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWGKVaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWGKVaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:30:06 -0400
Received: from mx.pathscale.com ([64.160.42.68]:52629 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751319AbWGKVaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:30:02 -0400
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to
	keep cache pressure down
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
In-Reply-To: <20060711.135729.104381402.davem@davemloft.net>
References: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
	 <20060711.135729.104381402.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 14:30:01 -0700
Message-Id: <1152653401.16499.35.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 13:57 -0700, David Miller wrote:

> Please don't use a weak attribute, and instead use the same
> "__HAVE_ARCH_FOO" cpp test scheme used for the other string
> operations to allow a platform to override the default
> implementation in lib/string.x

I'm a bit confused.

The last time I tried submitting a patch that followed that style (for
__iowrite_copy*), it got NAKed for propagating preprocessor abuse (Linus
roundly flamed someone for a similar patch a few weeks before I
submitted mine), and Andrew suggested that I use the same scheme that
this patch uses.

So whose instructions do I follow?  Yours of today, or Andrew's and
Linus's of a few months ago?

	<b

