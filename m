Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVAHSzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVAHSzL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 13:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVAHSzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 13:55:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:60592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261259AbVAHSzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 13:55:06 -0500
Date: Sat, 8 Jan 2005 10:54:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <Pine.LNX.4.44.0501081821510.4823-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501081051500.2386@ppc970.osdl.org>
References: <Pine.LNX.4.44.0501081821510.4823-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jan 2005, Hugh Dickins wrote:
> 
> Would a kernel build with "make -j18" count as existing practice?

Absolutely.

Looks like it does a single-byte write of '+' for each process started 
(and I assume it will do a '-' for each process that exits ;)

Oh, well. So much for my hope to avoid coalescing.

		Linus
