Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbWAJW32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWAJW32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWAJW32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:29:28 -0500
Received: from mx.pathscale.com ([64.160.42.68]:42936 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932578AbWAJW31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:29:27 -0500
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, rdreier@cisco.com, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060110140557.41e85f7d.akpm@osdl.org>
References: <patchbomb.1136579193@eng-12.pathscale.com>
	 <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
	 <20060110011844.7a4a1f90.akpm@osdl.org> <adaslrw3zfu.fsf@cisco.com>
	 <1136909276.32183.28.camel@serpentine.pathscale.com>
	 <20060110170722.GA3187@infradead.org>
	 <1136915386.6294.8.camel@serpentine.pathscale.com>
	 <20060110175131.GA5235@infradead.org>
	 <1136915714.6294.10.camel@serpentine.pathscale.com>
	 <20060110140557.41e85f7d.akpm@osdl.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 10 Jan 2006 14:29:22 -0800
Message-Id: <1136932162.6294.31.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 14:05 -0800, Andrew Morton wrote:

> It's kinda fun playing Brian along like this ;)

A regular barrel of monkeys, indeed...

> One option is to just stick the thing in an existing lib/ or kernel/ file
> and mark it __attribute__((weak)).  That way architectures can override it
> for free with no ifdefs, no Makefile trickery, no Kconfig trickery, etc.

I'm easy.  Would you prefer to take that, or the Kconfig-trickery-based
patch series I already posted earlier?

	<b

