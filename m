Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129310AbRBLUYa>; Mon, 12 Feb 2001 15:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbRBLUYK>; Mon, 12 Feb 2001 15:24:10 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:48376 "EHLO
	hoggar.fisica.ufpr.br") by vger.kernel.org with ESMTP
	id <S129231AbRBLUX7>; Mon, 12 Feb 2001 15:23:59 -0500
From: Carlos Carvalho <carlos@fisica.ufpr.br>
Message-ID: <14984.18005.694178.241076@hoggar.fisica.ufpr.br>
Date: Mon, 12 Feb 2001 18:23:49 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Subject: 2.2.19pre10 doesn't compile on alphas (sunrpc)
X-Mailer: VM 6.90 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When doing the final ld .... -o vmlinux on an alpha the linker
complains:

net/network.a(sunrpc.o): In function `xprt_ping_reserve':
sunrpc.o(.text+0x4b94): undefined reference to `BUG'
sunrpc.o(.text+0x4b98): undefined reference to `BUG'

Looks like a problem in Trond's patches, also it doesn't happen with
pre9. It links in intel machines. I didn't reboot to test yet...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
