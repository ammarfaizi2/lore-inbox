Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWGPTlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWGPTlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWGPTlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:41:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:9382 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750834AbWGPTlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:41:46 -0400
Date: Sun, 16 Jul 2006 21:41:34 +0200
From: Olaf Hering <olh@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc2
Message-ID: <20060716194134.GB17387@suse.de>
References: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Woodhouse:
>       [SPARC64]: Fix make headers_install
>       hdrinstall: remove asm/irq.h from user visibility
>       hdrinstall: remove asm/atomic.h from user visibility
>       hdrinstall: remove asm/io.h from user visibility

Why does the 'headers_install' target require a configured kernel?
I just ran 'make headers_install INSTALL_HDR_PATH=/dev/shm/$$'

Unrelated:
Cant you just export all asm-<arch> files? I guess they are all static.
