Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbUCOUt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 15:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUCOUt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 15:49:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5038 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262753AbUCOUt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 15:49:56 -0500
Date: Mon, 15 Mar 2004 12:49:06 -0800
From: "David S. Miller" <davem@redhat.com>
To: "chas williams (contractor)" <chas@cmf.nrl.navy.mil>
Cc: gator@cs.tu-berlin.de, linux-kernel@vger.kernel.org,
       linux-atm-general@lists.sourceforge.net
Subject: Re: [Linux-ATM-General] NICSTAR_USE_SUNI broken in 2.6.3+
Message-Id: <20040315124906.21dd0e88.davem@redhat.com>
In-Reply-To: <200403151728.i2FHSHgu021955@ginger.cmf.nrl.navy.mil>
References: <Pine.LNX.4.30.0403131045040.3568-100000@swamp.bayern.net>
	<200403151728.i2FHSHgu021955@ginger.cmf.nrl.navy.mil>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004 12:28:19 -0500
"chas williams (contractor)" <chas@cmf.nrl.navy.mil> wrote:

> this points directly to suni.c:236, in particular the PRIV(dev)->dev
> bit.  it looks like gcc3 fixups from akpm inadvertently converted PRIV()
> to dev_data instead of phy_data.
> 
> the following patch should get things running again.
> 
> dave, can you apply to 2.6?  thanks!

Applied, thanks Chas.
