Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUK3C0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUK3C0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUK3CZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:25:39 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:19924 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261932AbUK3CVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:21:22 -0500
Date: Tue, 30 Nov 2004 03:21:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org
Subject: Re: [1/7] Xen VMM #3: add ptep_establish_new to make va available
Message-ID: <20041130022105.GL4365@dualathlon.random>
References: <E1CYxP0-0005Hy-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYxP0-0005Hy-00@mta1.cl.cam.ac.uk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 02:06:02AM +0000, Ian Pratt wrote:
> 
> This patch adds 'ptep_establish_new', in keeping with the
> existing 'ptep_establish', but for use where a mapping is being
> established where there was previously none present. This
> function is useful (rather than just using set_pte) because
> having the virtual address available enables a very important
> optimisation for arch-xen. We introduce
> HAVE_ARCH_PTEP_ESTABLISH_NEW and define a generic implementation
> in asm-generic/pgtable.h, following the pattern of the existing
> ptep_establish.

this certainly is correct.
