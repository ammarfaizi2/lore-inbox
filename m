Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVCOSj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVCOSj6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVCOSiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:38:02 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:56492
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261752AbVCOSbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:31:42 -0500
Date: Tue, 15 Mar 2005 10:26:52 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/802/fc.c: remove fc_type_trans
Message-Id: <20050315102652.2d122c2f.davem@davemloft.net>
In-Reply-To: <20050315122017.GF3189@stusta.de>
References: <20050306205754.GO5070@stusta.de>
	<20050314214940.4947ccd9.davem@davemloft.net>
	<20050315122017.GF3189@stusta.de>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 13:20:17 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Mon, Mar 14, 2005 at 09:49:40PM -0800, David S. Miller wrote:
> > On Sun, 6 Mar 2005 21:57:54 +0100
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > The only user of fc_type_trans (drivers/net/fc/iph5526.c) is BROKEN in 
> > > 2.6 and removed in -mm.
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > That driver isn't in Linus's tree any longer either.  Just delete
> > the thing altogether instead of #if 0'ing it.
> >...
> 
> Updated patch:

Applied, thanks a lot Adrian.
