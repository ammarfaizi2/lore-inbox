Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVA3T7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVA3T7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 14:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVA3T7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 14:59:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:27062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261774AbVA3T7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 14:59:21 -0500
Date: Sun, 30 Jan 2005 11:58:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: bunk@stusta.de, werner@mrcoffee.engr.sgi.com, linux-kernel@vger.kernel.org,
       dwmw2@infradead.org, davej@codemonkey.org.uk
Subject: Re: inter-module-* removal.. small next step
Message-Id: <20050130115825.09d306e7.akpm@osdl.org>
In-Reply-To: <1107108932.4306.57.camel@laptopd505.fenrus.org>
References: <20050130180016.GA12987@infradead.org>
	<20050130181042.GR3185@stusta.de>
	<1107108932.4306.57.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Sun, 2005-01-30 at 19:10 +0100, Adrian Bunk wrote:
> > On Sun, Jan 30, 2005 at 06:00:17PM +0000, Arjan van de Ven wrote:
> > 
> > > Hi,
> > > 
> > > intermodule is deprecated for quite some time now, and MTD is the sole last
> > > user in the tree. To shrink the kernel for the people who don't use MTD, and
> > > to prevent accidental return of more users of this, make the compiling of
> > > this function conditional on MTD.
> > >...
> > 
> > agpgart-allow-multiple-backends-to-be-initialized.patch in -mm adds a 
> > call to inter_module_unregister to drivers/char/agp/backend.c ...
> 
> that is a bug in -mm; inter-module* got removed from agp entirely some
> time ago 

Michael's patches put it back in.  What's the fix?

