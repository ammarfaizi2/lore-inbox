Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTGXKTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 06:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTGXKTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 06:19:03 -0400
Received: from b0jm34bky18he.bc.hsia.telus.net ([64.180.152.77]:57102 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S261180AbTGXKTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 06:19:01 -0400
Date: Thu, 24 Jul 2003 03:33:18 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5 bk build failure.
Message-ID: <20030724103318.GA29694@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Searched the archive, found a few posts talking about this, but no solution
seems to have been posted.

Anyone have an idea?

Thanks,

        ld -m elf_i386  -T arch/i386/vmlinux.lds.s [snip]

drivers/built-in.o: In function `x25_asy_changed_mtu':
drivers/built-in.o(.text+0x6eae6): undefined reference to `save_flags'
drivers/built-in.o(.text+0x6eaeb): undefined reference to `cli'
drivers/built-in.o(.text+0x6eba1): undefined reference to `restore_flags'
make: *** [.tmp_vmlinux1] Error 1

-- DN
Daniel
