Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVGDXB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVGDXB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 19:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVGDXB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 19:01:58 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:36751
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261725AbVGDXB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 19:01:57 -0400
Subject: Re: 2.6.13-rc1-mm1: git-mtd.patch breaks i386 compile
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1120297044.9241.4.camel@tglx.tec.linutronix.de>
References: <20050701044018.281b1ebd.akpm@osdl.org>
	 <20050702091600.GF3592@stusta.de>
	 <1120297044.9241.4.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 05 Jul 2005 01:04:37 +0200
Message-Id: <1120518278.18862.107.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-02 at 11:37 +0200, Thomas Gleixner wrote:
> On Sat, 2005-07-02 at 11:16 +0200, Adrian Bunk wrote:
> > <--  snip  -->
> > drivers/mtd/chips/cfi_cmdset_0002.c:584:26: asm/hardware.h: No such file or directory
> > ...
> > make[3]: *** [drivers/mtd/chips/cfi_cmdset_0002.o] Error 1

Fixed in current mtd git tree. 

tglx


