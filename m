Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267280AbSLKU7B>; Wed, 11 Dec 2002 15:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267297AbSLKU7B>; Wed, 11 Dec 2002 15:59:01 -0500
Received: from dp.samba.org ([66.70.73.150]:28575 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267280AbSLKU7A>;
	Wed, 11 Dec 2002 15:59:00 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15863.43228.89337.776215@argo.ozlabs.ibm.com>
Date: Thu, 12 Dec 2002 08:06:36 +1100
To: James Simmons <jsimmons@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: atyfb in 2.5.51
In-Reply-To: <Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>
References: <1039596149.24691.2.camel@rth.ninka.net>
	<Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons writes:

> :-( True. We should always assume X or any userland app could be broken.

I don't think we can blame X in this particular situation.  When I
press ctrl-alt-F1 in X, it resets the screen to the colormap and depth
that the text console was using, but the kernel doesn't redraw the
text console screen image.  (I presume it also resets the resolution,
but since I have only tried on an LCD screen I can't say for sure.)

Paul.
