Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbUKRFQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbUKRFQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 00:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUKRFQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 00:16:49 -0500
Received: from mail.suse.de ([195.135.220.2]:49569 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262559AbUKRFQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 00:16:48 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Xen 2.0 VMM patches
References: <31IYf-4Y-5@gated-at.bofh.it>
From: Andi Kleen <ak@suse.de>
Date: 18 Nov 2004 05:50:54 +0100
In-Reply-To: <31IYf-4Y-5@gated-at.bofh.it>
Message-ID: <p73k6sj221d.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pratt <Ian.Pratt@cl.cam.ac.uk> writes:

>   arch-xen    : large patch to add arch/xen and include/asm-xen 

This is 32bit only right? Do you plan a 64bit guest too? 
If yes, you would end up with two arch-xens in the end.

Also are the differences to the native architecture really that big that a 
separate architecture makes sense? It's a lot of long term work to maintain
a Linux architecture.

-Andi
