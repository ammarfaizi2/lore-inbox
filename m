Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266731AbUGLF2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266731AbUGLF2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 01:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266733AbUGLF2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 01:28:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:62609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266731AbUGLF2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 01:28:47 -0400
Date: Sun, 11 Jul 2004 22:21:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] edd (Re: Linux 2.6.8-rc1)
Message-Id: <20040711222140.0c733693.rddunlap@osdl.org>
In-Reply-To: <20040712044946.GA21325@lists.us.dell.com>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
	<20040711160019.00c2d658.rddunlap@osdl.org>
	<20040712044946.GA21325@lists.us.dell.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004 23:49:46 -0500 Matt Domsch wrote:

| On Sun, Jul 11, 2004 at 04:00:19PM -0700, Randy.Dunlap wrote:
| > drivers/built-in.o: In function `edd_has_mbr_signature':
| > drivers/built-in.o(.text+0x13b84f): undefined reference to `edd'
| > drivers/built-in.o(.init.text+0xd39c): more undefined references to `edd' follow
| > 
| > CONFIG_EDD=y on X86o
| > 
| > 'edd' needs to be exported for drivers/firmware/edd.c
| 
| I don't think so.  It only needs be exported if a module is going to
| use it.  Since you're building it in, not as a module, it should be
| fine.
| 
| My own 'make defconfig' on a clean BK tree, enabling CONFIG_EDD=y,
| links correctly.  Perhaps a make mrproper; make would be in order, as the
| deps stage should have caught it for you...

OK, I don't know how it happened, but not a problem now.

Sorry about that.

--
~Randy
