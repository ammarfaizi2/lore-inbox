Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267597AbUHPMwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267597AbUHPMwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUHPMwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:52:45 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:60159 "EHLO
	mailfe04.swip.net") by vger.kernel.org with ESMTP id S267597AbUHPMwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:52:33 -0400
X-T2-Posting-ID: /sknEDxqgNYILdIqM8RWvsxa4S0yaaQlkxq/GXpTp0w=
From: jjluza <jjluza@yahoo.fr>
Reply-To: jjluza@yahoo.fr
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
Date: Mon, 16 Aug 2004 14:52:44 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408161452.44400.jjluza@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It fails here at compile time with :

arch/i386/kernel/built-in.o(.text+0x2fc5): In function `do_nmi':
: undefined reference to `__trace'
arch/i386/kernel/built-in.o(.text+0x3723): In function `do_IRQ':
: undefined reference to `__trace'
arch/i386/mm/built-in.o(.text+0x7ba): In function `do_page_fault':
: undefined reference to `__trace'
make[1]: *** [vmlinux] Erreur 1
make[1]: Leaving directory `/usr/src/linux-2.6.8'
make: *** [stamp-build] Erreur 2


I also got offset when applying the patch. (P1 hadn't this problem)


Regards.
