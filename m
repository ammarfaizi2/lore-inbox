Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbSJaThf>; Thu, 31 Oct 2002 14:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265427AbSJaTh3>; Thu, 31 Oct 2002 14:37:29 -0500
Received: from tapu.f00f.org ([66.60.186.129]:46054 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S265425AbSJaThY>;
	Thu, 31 Oct 2002 14:37:24 -0500
Date: Thu, 31 Oct 2002 11:43:51 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Dax Kelson <dax@gurulabs.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031194351.GA24676@tapu.f00f.org>
References: <20021031181252.GB24027@tapu.f00f.org> <Pine.LNX.4.44.0210311040080.1526-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210311040080.1526-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 10:49:10AM -0800, Linus Torvalds wrote:

> Any hardware that needs to go off and think about how to encrypt
> something sounds like it's so slow as to be unusable. I suspect that
> anything that is over the PCI bus is already so slow (even if it
> adds no extra cycles of its own) that you're better off using the
> CPU for the encryption rather than some external hardware.

Except almost all hardware out there that does this stuff is async to
some extent...

I'm just speaking as someone who has (sadly) done this a couple of
times already for commercial real-world products.  I'm no expert, I
don't claim to be and admit there is still plenty to learn...

... that said, having access to lots of hardware, both our own and
other peoples, almost all of it needs to be driven asynchronously to
get good performance (or by a large number of threads).


