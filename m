Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315461AbSFJTVt>; Mon, 10 Jun 2002 15:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315808AbSFJTVs>; Mon, 10 Jun 2002 15:21:48 -0400
Received: from [209.237.59.50] ([209.237.59.50]:26676 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S315461AbSFJTVr>; Mon, 10 Jun 2002 15:21:47 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <523cvv9laj.fsf@topspin.com>
	<20020610170309.GC14252@opus.bloom.county>
	<200206101922.26985.oliver@neukum.name>
	<20020610172909.GE14252@opus.bloom.county>
	<52ptyz7y88.fsf@topspin.com>
	<20020610191434.GI14252@opus.bloom.county>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Jun 2002 12:21:44 -0700
Message-ID: <52fzzv7xdj.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

    Tom> SMP_CACHE_BYTES is non-sensical on 4xx (and 8xx) since they
    Tom> don't do SMP..

True but <asm/cache.h> defines it anyway...  of course it would be no
problem to use L1_CACHE_BYTES and in fact that probably makes sense
because we're talking about PPC-only macros (other arches would have
their own definition).

Best,
  Roland

