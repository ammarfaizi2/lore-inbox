Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWBGW5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWBGW5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWBGW5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:57:53 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9344
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030227AbWBGW5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:57:52 -0500
Date: Tue, 07 Feb 2006 14:57:25 -0800 (PST)
Message-Id: <20060207.145725.22157385.davem@davemloft.net>
To: heiko.carstens@de.ibm.com
Cc: sfr@canb.auug.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, ak@suse.de, linuxppc64-dev@ozlabs.org,
       paulus@samba.org
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060207132949.GB9311@osiris.boeblingen.de.ibm.com>
References: <20060207174017.5e3b0ce0.sfr@canb.auug.org.au>
	<20060207093154.GA9311@osiris.boeblingen.de.ibm.com>
	<20060207132949.GB9311@osiris.boeblingen.de.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 7 Feb 2006 14:29:49 +0100

> Ah, stupid me... the SARG define defines assembly code of course. Just
> that we would need different defines for arguments that are in registers
> or on the stack. Is s390 the only architecture that has argument six on
> the stack?

If I remember correctly, o32 mips binaries put arg 6 on the stack
too.
