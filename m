Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268689AbTGOQ2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268836AbTGOQ2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:28:22 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:2056 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268689AbTGOQ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:26:04 -0400
Date: Tue, 15 Jul 2003 17:40:52 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: dank@reflexsecurity.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
In-Reply-To: <bf19d5$d00$1@main.gmane.org>
Message-ID: <Pine.LNX.4.44.0307151740040.7091-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > drivers/built-in.o(.text+0x66e7a): In function `matroxfb_set_par':
> >: undefined reference to `default_grn'
> > drivers/built-in.o(.text+0x66e7f): In function `matroxfb_set_par':
> >: undefined reference to `default_blu'
> > drivers/built-in.o(.text+0x66e93): In function `matroxfb_set_par':
> >: undefined reference to `color_table'
> > drivers/built-in.o(.text+0x66e9b): In function `matroxfb_set_par':
> >: undefined reference to `default_red'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> you'll need to build VT support.

Ug. That is wrong. Fbdev driver are independent of the console layer.


