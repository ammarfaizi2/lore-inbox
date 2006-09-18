Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWIRHky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWIRHky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 03:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWIRHky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 03:40:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40638
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751572AbWIRHkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 03:40:53 -0400
Date: Mon, 18 Sep 2006 00:40:51 -0700 (PDT)
Message-Id: <20060918.004051.49243272.davem@davemloft.net>
To: sri@us.ibm.com
Cc: bunk@stusta.de, lksctp-developers@lists.sourceforge.net,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       dwmw2@infradead.org
Subject: Re: [2.6 patch] net/sctp/: cleanups
From: David Miller <davem@davemloft.net>
In-Reply-To: <1157499861.3728.7.camel@w-sridhar2.beaverton.ibm.com>
References: <20060905215721.GM9173@stusta.de>
	<1157499861.3728.7.camel@w-sridhar2.beaverton.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sridhar Samudrala <sri@us.ibm.com>
Date: Tue, 05 Sep 2006 16:44:21 -0700

> On Tue, 2006-09-05 at 23:57 +0200, Adrian Bunk wrote:
> > This patch contains the following cleanups:
> > - make the following needlessly global function static:
> >   - socket.c: sctp_apply_peer_addr_params()
> > - add proper prototypes for the several global functions in
> >   include/net/sctp/sctp.h
> > 
> > Note that this fixes wrong prototypes for the following functions:
> > - sctp_snmp_proc_exit()
> > - sctp_eps_proc_exit()
> > - sctp_assocs_proc_exit()
> > 
> > The latter was spotted by the GNU C compiler and reported
> > by David Woodhouse.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Acked-by: Sridhar Samudrala <sri@us.ibm.com>

Applied, thanks.
