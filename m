Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVAZAH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVAZAH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVAZAGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:06:37 -0500
Received: from ozlabs.org ([203.10.76.45]:7312 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262248AbVAZAFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:05:45 -0500
Date: Wed, 26 Jan 2005 11:01:36 +1100
From: Anton Blanchard <anton@samba.org>
To: Ian Molton <spyro@f2s.com>, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use MM_VM_SIZE in exit_mmap
Message-ID: <20050126000136.GB27433@krispykreme.ozlabs.ibm.com>
References: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com> <41F6CFF2.7010907@f2s.com> <20050125233949.C30094@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125233949.C30094@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> I don't think Anton can count.  (and for some reason I seem to be missing
> his mail at the moment.)
> 
> include/asm-arm/pgtable.h:#define FIRST_USER_PGD_NR     1
> 
> there's two.  FIRST_USER_PGD_NR was created specifically for ARM because
> many of our CPUs place their hardware vector tables at *virtual* address
> zero.  Unmapping this virtual page would be rather bad for the system -
> consider the effect of unmapping the code for *all* CPU exceptions.

It does look like I have trouble counting past 1 :) Lets forget that
proposal, it was just a minor cleanup anyway.

Anton
