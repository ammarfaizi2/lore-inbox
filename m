Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbUEaLKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUEaLKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 07:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUEaLKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 07:10:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263370AbUEaLKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 07:10:19 -0400
Date: Mon, 31 May 2004 08:11:15 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>
Cc: mikpe@csd.uu.se, davem@redhat.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][2.4.27-pre4] tcp_input.c compile-time error
Message-ID: <20040531111114.GA19839@logos.cnet>
References: <40BAF132.5010907@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BAF132.5010907@ribosome.natur.cuni.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 10:47:46AM +0200, Martin MOKREJ? wrote:
> This patch has helped to me to compile teh kernel at least. Thanks.
> 
> 
> net/ipv4/tcp_input.c in 2.4.27-pre4 fails to compile:
> 
> tcp_input.c: In function `tcp_rcv_space_adjust':
> tcp_input.c:479: error: structure has no member named `sk_rcvbuf'
> tcp_input.c:480: error: structure has no member named `sk_rcvbuf'
> make[3]: *** [tcp_input.o] Error 1
> 
> The patch below appears to fix this problem, although some netdev
> person should probably check it.

Just pulled davem's tree with a fix. -BK is fixed now.

Thanks!
