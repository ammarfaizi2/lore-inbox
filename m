Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVIMQQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVIMQQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVIMQQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:16:47 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:18048 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S964839AbVIMQQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:16:47 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17190.33539.992902.463545@gargle.gargle.HOWL>
Date: Tue, 13 Sep 2005 11:42:59 +0400
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       jirislaby@gmail.com, lion.vollnhals@web.de
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
Newsgroups: gmane.linux.kernel
In-Reply-To: <Pine.LNX.4.58.0509131001400.31456@sbz-30.cs.Helsinki.FI>
References: <200509130010.38483.lion.vollnhals@web.de>
	<43260817.7070907@gmail.com>
	<84144f0205091221431827b126@mail.gmail.com>
	<200509130033.11109.dtor_core@ameritech.net>
	<20050912234200.10b2abe7.akpm@osdl.org>
	<Pine.LNX.4.58.0509131001400.31456@sbz-30.cs.Helsinki.FI>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg writes:

[...]

 > +
 > +The kernel provides the following general purpose memory allocators:
 > +kmalloc(), kzalloc(), kcalloc(), and vmalloc().  Please refer to the API
 > +documentation for further information about them.
 > +
 > +The preferred form for passing a size of a struct is the following:
 > +
 > +	p = kmalloc(sizeof(*p), ...);

Parentheses around *p are superfluous. See

 >   The C Programming Language, Second Edition
 >   by Brian W. Kernighan and Dennis M. Ritchie.

Nikita.
