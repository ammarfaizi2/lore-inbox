Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbTCESlU>; Wed, 5 Mar 2003 13:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTCESlU>; Wed, 5 Mar 2003 13:41:20 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:1549 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267427AbTCESlU>; Wed, 5 Mar 2003 13:41:20 -0500
Date: Wed, 5 Mar 2003 18:51:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Derek Atkins <derek@ihtfp.com>
Cc: Kostadin Karaivanov <larry@minfin.bg>, linux-kernel@vger.kernel.org
Subject: Re: ipsec-tools 0.1 + kernel 2.5.64
Message-ID: <20030305185149.A28243@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Derek Atkins <derek@ihtfp.com>,
	Kostadin Karaivanov <larry@minfin.bg>, linux-kernel@vger.kernel.org
References: <sjmof4pvfx7.fsf@kikki.mit.edu> <20030305182715.A27888@infradead.org> <sjmbs0pvelp.fsf@kikki.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <sjmbs0pvelp.fsf@kikki.mit.edu>; from derek@ihtfp.com on Wed, Mar 05, 2003 at 01:43:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 01:43:30PM -0500, Derek Atkins wrote:
> Well, the problem is that the replacement function is only valid on
> Linux, so I need to have the <OS> test in there anyways.

It's probably not valid on Linux but on OSes that support the functionality
you use to implement it.  It might e.g. work on the Hurd that uses old
Linux networking code.

> It may be
> "bad style", but the test needs to exist _somewhere_.  Besides, I've
> never been one to be convinced to do something purely based on
> stylistic arguments.  Give me a real technical reason why it needs to
> be different and I'll consider changing it.

Checking for OSes is wrong because you couldn't care less for the
OS, you care for the functionality that is provided.  This is the
nice idea behind autoconf (the implementation of autoconf is a completly
different issue, though).


