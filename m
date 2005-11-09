Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVKIXbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVKIXbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVKIXbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:31:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:30896 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751001AbVKIXbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:31:04 -0500
Subject: Re: [PATCH] AGP performance fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Dave Jones <davej@redhat.com>, Alan Hourihane <alanh@fairlite.demon.co.uk>
In-Reply-To: <200511092002.jA9K25J8025643@hera.kernel.org>
References: <200511092002.jA9K25J8025643@hera.kernel.org>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 10:29:15 +1100
Message-Id: <1131578955.24637.116.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 12:02 -0800, Linux Kernel Mailing List wrote:
> tree 048db8e12c2b31ec2b88c3154da4c6a77b80028c
> parent 329f7dba5f7dc3bc9a30ad00cf373d2e83115aa1
> author Alan Hourihane <alanh@fairlite.demon.co.uk> Mon, 07 Nov 2005 15:35:34 -0800
> committer Dave Jones <davej@redhat.com> Wed, 09 Nov 2005 05:43:54 -0800
> 
> [PATCH] AGP performance fixes
> 
> AGP allocation/deallocation is suffering major performance issues due to
> the nature of global_flush_tlb() being called on every change_page_attr()
> call.

 .../...

*** Warning: ".global_flush_tlb" [drivers/char/agp/agpgart.ko] undefined!

Am I supposed to define something new for uninorth-agp ? Is this yet another
x86-only (or worse, some x86 chipsets only concept going global ?

Ben.


