Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbUK3SVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbUK3SVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbUK3SVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:21:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:41613 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262229AbUK3SVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:21:30 -0500
Date: Tue, 30 Nov 2004 10:21:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4
Message-Id: <20041130102105.21750596.akpm@osdl.org>
In-Reply-To: <1101837994.2640.67.camel@laptop.fenrus.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
	<1101837994.2640.67.camel@laptop.fenrus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Tue, 2004-11-30 at 09:50 -0800, Andrew Morton wrote:
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
> > 
> > - Various fixes and cleanups
> > 
> > - A decent-sized x86_64 update.
> > 
> > - x86_64 supports a fourth VM zone: ZONE_DMA32.  This may affect memory
> >   reclaim, but shouldn't.
> 
> 
> what is the purpose of such a zone ??

For pages which have a physical address <4G.  I assume this was motivated
by the lack of an IOMMU on ia32e?
