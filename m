Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTD3XeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTD3XeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:34:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6807
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262577AbTD3XeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:34:15 -0400
Subject: Re: [RFC][PATCH] Faster generic_fls
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
       dphillips@sistina.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304301640110.19484-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0304301640110.19484-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051742871.20265.35.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Apr 2003 23:47:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-01 at 00:41, Linus Torvalds wrote:
> On 30 Apr 2003, Alan Cox wrote:
> > 
> > It ought to be basically the same as ffs because if I remember rightly 
> > 
> > ffs(x^(x-1)) == fls(x)
> 
> So did anybody time this? ffs() we have hardware support for on x86, and 
> it's even reasonably efficient on some CPU's .. So this _should_ beat all 
> new-comers, and obviously some people already have benchmark programs 
> ready and willing..

Unfortunately on digging up my notes it seems I got ffs/fls backwards so it doesnt
help us a great deal.

