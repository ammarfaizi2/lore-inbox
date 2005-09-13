Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVIMQb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVIMQb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVIMQb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:31:59 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:16275 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964859AbVIMQb6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:31:58 -0400
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       jirislaby@gmail.com, lion.vollnhals@web.de
In-Reply-To: <17190.33539.992902.463545@gargle.gargle.HOWL>
References: <200509130010.38483.lion.vollnhals@web.de>
	 <43260817.7070907@gmail.com> <84144f0205091221431827b126@mail.gmail.com>
	 <200509130033.11109.dtor_core@ameritech.net>
	 <20050912234200.10b2abe7.akpm@osdl.org>
	 <Pine.LNX.4.58.0509131001400.31456@sbz-30.cs.Helsinki.FI>
	 <17190.33539.992902.463545@gargle.gargle.HOWL>
Date: Tue, 13 Sep 2005 19:31:53 +0300
Message-Id: <1126629113.8494.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg writes:
>  > +The kernel provides the following general purpose memory allocators:
>  > +kmalloc(), kzalloc(), kcalloc(), and vmalloc().  Please refer to the API
>  > +documentation for further information about them.
>  > +
>  > +The preferred form for passing a size of a struct is the following:
>  > +
>  > +	p = kmalloc(sizeof(*p), ...);

On Tue, 2005-09-13 at 11:42 +0400, Nikita Danilov wrote:
> Parentheses around *p are superfluous. See

Sure but is it the preferred form for the kernel?

			Pekka

