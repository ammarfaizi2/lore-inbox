Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271310AbTHCVo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271307AbTHCVo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:44:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19433 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271302AbTHCVo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:44:27 -0400
Date: Sun, 3 Aug 2003 14:39:58 -0700
From: "David S. Miller" <davem@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: herbert@gondor.apana.org.au, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: net/ipv4/ipcomp.c in 2.6.0-test2
Message-Id: <20030803143958.190272e1.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0308031315370.799-100000@vervain.sonytel.be>
References: <E19j8Ln-0002rE-00@gondolin.me.apana.org.au>
	<Pine.GSO.4.21.0308031315370.799-100000@vervain.sonytel.be>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003 13:17:03 +0200 (MEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Sun, 3 Aug 2003, Herbert Xu wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > Looks like CONFIG_INET_IPCOMP=y needs CONFIG_CRYPTO_HMAC=y
> > 
> > Does it help if you remove the inclusion of net/esp.h from ipcomp.c?
> 
> Yes it does.

Applied, thanks guys.
