Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWGKVfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWGKVfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWGKVfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:35:20 -0400
Received: from mx.pathscale.com ([64.160.42.68]:14998 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750772AbWGKVfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:35:19 -0400
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to
	keep cache pressure down
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, arjan@infradead.org
In-Reply-To: <20060711140951.f22847d8.rdunlap@xenotime.net>
References: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
	 <20060711140951.f22847d8.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 14:35:19 -0700
Message-Id: <1152653719.16499.41.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 14:09 -0700, Randy.Dunlap wrote:

> space after commas, please.

Yep.

> Currently kernel-doc function description is limited to one line.

Ugh, OK.  What about "Memory copy, bypassing CPU cache for loads" for
the one-liner?  And a suitably modified first paragraph to make it clear
that on some arches, it falls back to memcpy.

Thanks,

	<b

