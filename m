Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbUKNHfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbUKNHfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 02:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUKNHfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 02:35:14 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:47821
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261254AbUKNHfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 02:35:10 -0500
Date: Sat, 13 Nov 2004 23:18:02 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: robert.olsson@its.uu.se, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] net/core/pktgen.c shouldn't include pci.h
Message-Id: <20041113231802.0704083e.davem@davemloft.net>
In-Reply-To: <20041113145351.GZ2249@stusta.de>
References: <20041113145351.GZ2249@stusta.de>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2004 15:53:51 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> If rebuilding after touching pci.h in 2.6, net/core/pktgen.c is the only 
> file under net/ that gets rebuilt.
> 
> I searched and didn't find any reason why net/core/pktgen.c needs to 
> include pci.h .
> 
> I'm therefore suggesting the patch below (applies against both 2.4
> and 2.6).

Yeah, that's pretty weird.  Patch applied, thanks Adrian :)
