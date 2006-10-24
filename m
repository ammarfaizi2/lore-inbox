Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWJXMTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWJXMTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbWJXMTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:19:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21711 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161018AbWJXMTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:19:03 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Giridhar Pemmasani <pgiri@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <84144f020610240512y80a41bblcf8ce08c3875c008@mail.gmail.com>
References: <1161608452.19388.31.camel@localhost.localdomain>
	 <20061024024347.57840.qmail@web32414.mail.mud.yahoo.com>
	 <20061023201135.0d8766c9.rdunlap@xenotime.net>
	 <84144f020610240512y80a41bblcf8ce08c3875c008@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Oct 2006 13:22:13 +0100
Message-Id: <1161692533.22348.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-24 am 15:12 +0300, ysgrifennodd Pekka Enberg:
> On 10/24/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > The kernel should not depend on a not-in-tree kernel module to
> > taint the kernel.  The kernel can and should do that itself.
> 
> Agreed. But should the kernel disallow the use of _GPL symbols for
> ndiswrapper? I would say no.

I'd agree providing the attempt to taint function allows an error return
if it did so and it then refuses to load non-GPL windows drivers.

