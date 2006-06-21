Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751941AbWFUDAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbWFUDAM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 23:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWFUDAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 23:00:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21423 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751941AbWFUDAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 23:00:10 -0400
Date: Tue, 20 Jun 2006 19:59:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Garzik <jeff@garzik.org>, ak@suse.de, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git build breakage
In-Reply-To: <20060620011738.d72147a8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606201957420.5498@g5.osdl.org>
References: <4497A871.8000303@garzik.org> <20060620011738.d72147a8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jun 2006, Andrew Morton wrote:

> On Tue, 20 Jun 2006 03:49:05 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > On the latest 'git pull', on x86-64 SMP 'make allmodconfig', I get the 
> > following build breakage:
> > 
> > 1) myri10ge: needs iowrite64_copy from -mm
> 
> Patch has been sent.

Actually, not as far as I can tell.

I got "s390: add __raw_writeq required by __iowrite64_copy" which was 
apparently the requisite patch for the actual iowrite64_patch.

But no iowrite64 patch itself. Andrew?

		Lins
