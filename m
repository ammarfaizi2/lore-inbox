Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUK3MUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUK3MUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 07:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUK3MUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 07:20:05 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41133 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262050AbUK3MTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 07:19:05 -0500
Message-Id: <200411301218.iAUCI4o7003833@laptop11.inf.utfsm.cl>
To: Matthew Wilcox <matthew@wil.cx>
cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       Alexandre Oliva <aoliva@redhat.com>, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__ 
In-Reply-To: Message from Matthew Wilcox <matthew@wil.cx> 
   of "Fri, 26 Nov 2004 14:19:35 -0000." <20041126141935.GA29035@parcelfarce.linux.theplanet.co.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 30 Nov 2004 09:18:04 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> said:
> On Fri, Nov 26, 2004 at 12:00:43PM +0000, David Woodhouse wrote:
> > On Fri, 2004-11-26 at 11:58 +0000, David Howells wrote:

> > > How about calling the interface headers "kapi*/" instead of "user*/".
> > > In case you haven't guessed, "kapi" would be short for "kernel-api".

> > I don't think that change really makes any difference. The nomenclature
> > really isn't _that_ important.

> Indeed.  We could also make this transparent to userspace by using a script
> to copy the user-* headers to /usr/include.  Something like this:

And get them promptly out of sync with glibc &c when the kernel changes.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
