Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVAHS0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVAHS0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 13:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVAHS0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 13:26:01 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43971 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261230AbVAHSZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 13:25:58 -0500
Date: Sat, 8 Jan 2005 18:25:17 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather than
In-Reply-To: <Pine.LNX.4.58.0501070910000.2272@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0501081821510.4823-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005, Linus Torvalds wrote:
> 
> Hmm.. Are there really any other guarantees than the atomicity guarantee 
> for a PIPE_BUF transfer? I don't see any in SuS..
> 
> That said, existing practice obviously always trumps paper standards, and 
> yes, coalescing is possible.

Would a kernel build with "make -j18" count as existing practice?
Immediately hangs for me...

Hugh

