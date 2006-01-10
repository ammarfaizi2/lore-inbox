Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWAJRNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWAJRNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWAJRNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:13:55 -0500
Received: from mx.pathscale.com ([64.160.42.68]:34203 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932277AbWAJRNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:13:54 -0500
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Roland Dreier <rdreier@cisco.com>, sam@ravnborg.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060110170722.GA3187@infradead.org>
References: <patchbomb.1136579193@eng-12.pathscale.com>
	 <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
	 <20060110011844.7a4a1f90.akpm@osdl.org> <adaslrw3zfu.fsf@cisco.com>
	 <1136909276.32183.28.camel@serpentine.pathscale.com>
	 <20060110170722.GA3187@infradead.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 10 Jan 2006 09:13:51 -0800
Message-Id: <1136913231.6294.2.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 17:07 +0000, Christoph Hellwig wrote:

> Or add a CONFIG_GENERIC_MEMCPY_IO that's non-uservisible and just set
> by all the architectures that don't provide their own version.

That's only very slightly different from the RFC patch I just posted.
If you think it would be a preferable way to express it, that's fine by
me.  It would at least keep me from crapping on every arch's
lib/Makefile.

> And once
> we're at that level of complexity we should really add the _fromio version
> aswell

I'm already being raked over the coals enough for a routine that has an
actual user waiting in the wings :-)

	<b

