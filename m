Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUJMFef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUJMFef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUJMFef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:34:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:51118 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268360AbUJMFed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:34:33 -0400
Date: Tue, 12 Oct 2004 22:32:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hirokazu Takata <takata.hirokazu@renesas.com>
Cc: jgarzik@pobox.com, takata@linux-m32r.org, linux-kernel@vger.kernel.org,
       paul.mundt@nokia.com, nico@cam.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2.6.9-rc4-mm1] [m32r] Fix smc91x driver for m32r
Message-Id: <20041012223227.45a62301.akpm@osdl.org>
In-Reply-To: <20041013.121547.863739114.takata.hirokazu@renesas.com>
References: <416BFD79.1010306@pobox.com>
	<20041013.105243.511706221.takata.hirokazu@renesas.com>
	<416C8E0B.4030409@pobox.com>
	<20041013.121547.863739114.takata.hirokazu@renesas.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takata <takata.hirokazu@renesas.com> wrote:
>
>  This patch has been already applied to 2.6.9-rc4-mm1 kernel and 
>  you can also find it as
>  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/m32r-trivial-fix-of-smc91xh.patch

Well actually:

smc91x-revert-11923358-m32r-modify-drivers-net-smc91xc.patch
smc91x-assorted-minor-cleanups.patch
smc91x-set-the-mac-addr-from-the-smc_enable-function.patch
smc91x-fold-smc_setmulticast-into-smc_set_multicast_list.patch
smc91x-simplify-register-bank-usage.patch
smc91x-move-tx-processing-out-of-irq-context-entirely.patch
smc91x-use-a-work-queue-to-reconfigure-the-phy-from.patch
smc91x-fix-possible-leak-of-the-skb-waiting-for-mem.patch
smc91x-display-pertinent-register-values-from-the.patch
smc91x-straighten-smp-locking.patch
smc91x-cosmetics.patch
m32r-trivial-fix-of-smc91xh.patch
smc91x-fix-smp-lock-usage.patch
smc91x-more-smp-locking-fixes.patch
smc91x-fix-compilation-with-dma-on-pxa2xx.patch
smc91x-receives-two-bytes-too-many.patch
smc91x-release-on-chip-rx-packet-memory-asap.patch

I'll unload all those onto Jeff...
