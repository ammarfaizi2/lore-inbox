Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbULPUCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbULPUCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbULPUCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:02:09 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:21478 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261964AbULPUB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:01:56 -0500
Subject: Re: arch/xen is a bad idea
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Ian.Pratt@cl.cam.ac.uk, riel@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
In-Reply-To: <20041216102652.6a5104d2.akpm@osdl.org>
References: <p73acsg1za1.fsf@bragg.suse.de>
	 <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
	 <20041215044927.GF27225@wotan.suse.de>
	 <1103155782.3585.29.camel@localhost.localdomain>
	 <20041216040136.GA30555@wotan.suse.de>
	 <1103201656.3804.7.camel@localhost.localdomain>
	 <20041216140954.GA29761@wotan.suse.de>
	 <20041216102652.6a5104d2.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103223432.21823.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 18:57:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 18:26, Andrew Morton wrote:
> I guess if we were to go the way which Ian is proposing it would be
> 
> a) Add arch/xen
> 
> b) Spend N weeks integrating xen into arch/i386, while also separately
>    maintaining arch/xen.
> 
> c) Remove arch/xen
> 
> So...  why not skip a), c) and half of b)?

Because until xen is in the kernel it won't get good exposure
Because nobody is sure that b) needs to occur or would occur for another
year our two (Xen3)

Xen is not "a slightly x86 arch variant" (and a slight ia64 arch
variant) Xen is quite different in its design and its performance comes
from exactly that - paravirtualisation by being a virtual CPU that isn't
a true x86 is very very fast.

b is a long term research project it is not a "clean this up next month"
project as I understand it. 


