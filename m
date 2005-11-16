Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbVKPF1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVKPF1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 00:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVKPF1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 00:27:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932584AbVKPF1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 00:27:08 -0500
Date: Tue, 15 Nov 2005 21:26:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: arnd@arndb.de, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       mnutter@us.ibm.com, arndb@de.ibm.com
Subject: Re: [PATCH 1/5] spufs: The SPU file system, base
Message-Id: <20051115212638.5dca4a66.akpm@osdl.org>
In-Reply-To: <17274.49289.583486.477211@cargo.ozlabs.ibm.com>
References: <20051115205347.395355000@localhost>
	<20051115210408.327453000@localhost>
	<17274.49289.583486.477211@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Arnd Bergmann writes:
> 
> > --- linux-2.6.15-rc.orig/arch/ppc/kernel/ppc_ksyms.c
> > +++ linux-2.6.15-rc/arch/ppc/kernel/ppc_ksyms.c
> > @@ -311,7 +311,6 @@ EXPORT_SYMBOL(__res);
> >  
> >  EXPORT_SYMBOL(next_mmu_context);
> >  EXPORT_SYMBOL(set_context);
> > -EXPORT_SYMBOL_GPL(__handle_mm_fault); /* For MOL */
> 
> Why?  What have you got against MOL? :)
> 

The export was moved to mm/memory.c.   No explanation why though...
