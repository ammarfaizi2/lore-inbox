Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbTD3X1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbTD3X1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:27:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44806 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262526AbTD3X1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:27:52 -0400
Date: Wed, 30 Apr 2003 16:41:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
       <dphillips@sistina.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
In-Reply-To: <1051734350.20270.28.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0304301640110.19484-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Apr 2003, Alan Cox wrote:
> 
> It ought to be basically the same as ffs because if I remember rightly 
> 
> ffs(x^(x-1)) == fls(x)

So did anybody time this? ffs() we have hardware support for on x86, and 
it's even reasonably efficient on some CPU's .. So this _should_ beat all 
new-comers, and obviously some people already have benchmark programs 
ready and willing..

		Linus

