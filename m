Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbUK3SKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbUK3SKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUK3SGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:06:52 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:31632 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262083AbUK3SEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:04:13 -0500
Date: Tue, 30 Nov 2004 19:03:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [4/7] Xen VMM patch set : /dev/mem io_remap_page_range for CONFIG_XEN
Message-ID: <20041130180337.GT4365@dualathlon.random>
References: <1101816850.2640.43.camel@laptop.fenrus.org> <E1CZ7sH-0006Si-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CZ7sH-0006Si-00@mta1.cl.cam.ac.uk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 01:16:56PM +0000, Ian Pratt wrote:
> point it would solve our problem. I'm not sure what this would
> mean for architectures other than i386.

Only sparc implements io_remap_page_range differently from
remap_pte_range and from Wli answer I understand it's probably ok for
sparc to use io_remap_page_range outside ram.
