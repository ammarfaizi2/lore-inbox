Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVBOSnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVBOSnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVBOSlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:41:45 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:59310
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261813AbVBOSkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:40:36 -0500
Date: Tue, 15 Feb 2005 10:37:55 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
       ralf@linux-mips.org, tony.luck@intel.com, ak@suse.de, willy@debian.org,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-Id: <20050215103755.4b118f33.davem@davemloft.net>
In-Reply-To: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005 14:01:49 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> This patch does:
> 	- consolidate the three implementations of compat_sys_waitid
> 	  (some were called sys32_waitid).
> 	- adds sys_waitid syscall to ppc
> 	- adds sys_waitid and compat_sys_waitid syscalls to ppc64
> 
> Parisc seemed to assume th existance of compat_sys_waitid.  The MIPS
> syscall tables have me confused and may need updating.  I have arbitrarily
> chosen the next available syscall number on ppc and ppc64, I hope this is
> correct.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Comments?

Looks good to me.
