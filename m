Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbUKHB6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUKHB6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 20:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUKHB6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 20:58:16 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:44937
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261727AbUKHB6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 20:58:12 -0500
Date: Sun, 7 Nov 2004 17:42:47 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: marcelo.tosatti@cyclades.com, laforge@netfilter.org,
       linux-kernel@vger.kernel.org, chas@cmf.nrl.navy.mil,
       linux-atm-general@lists.sourceforge.net, linux-net@vger.kernel.org
Subject: Re: 2.4.28-rc2: net/atm/proc.c compile error
Message-Id: <20041107174247.559be214.davem@davemloft.net>
In-Reply-To: <20041107214246.GY14308@stusta.de>
References: <20041107173753.GB30130@logos.cnet>
	<20041107214246.GY14308@stusta.de>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Nov 2004 22:42:46 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Sun, Nov 07, 2004 at 03:37:53PM -0200, Marcelo Tosatti wrote:
> >...
> > Summary of changes from v2.4.28-rc1 to v2.4.28-rc2
> > ============================================
> >...
> > Harald Welte:
> >   o [NET]: Backport neighbour scalability fixes from 2.6.x
> >...
> 
> 
> This patch removes atm_lec_info but not the user of this function, 
> resulting in the following compile error:

You must have mispatched, here is a grep I just did in Marcelo's
current tree:

davem@nuts:/disk1/BK/marcelo-2.4/net/atm$ egrep atm_lec_info *.c
davem@nuts:/disk1/BK/marcelo-2.4/net/atm$ 
