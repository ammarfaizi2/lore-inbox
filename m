Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSL3A1n>; Sun, 29 Dec 2002 19:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSL3A1n>; Sun, 29 Dec 2002 19:27:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17280
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262500AbSL3A1m>; Sun, 29 Dec 2002 19:27:42 -0500
Subject: Re: [PATCH] 2.5.53 : drivers/net/wan/x25_asy.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank Davis <fdavis@si.rr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212282000520.952-100000@linux-dev>
References: <Pine.LNX.4.44.0212282000520.952-100000@linux-dev>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 01:17:23 +0000
Message-Id: <1041211043.1215.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-29 at 01:04, Frank Davis wrote:
> Hello all,
>   The attached patch swaps the save_flags/cli/restore_flags combo with a 
> spinlock.  Please review.

You need to take the lock on the irq path as well

