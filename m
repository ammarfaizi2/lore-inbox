Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270013AbTGaWMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274824AbTGaWMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:12:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:31164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270013AbTGaWLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:11:44 -0400
Date: Thu, 31 Jul 2003 14:59:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Bakos <bakhos@msi.umn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile error for Opteron CPU with kernel 2.6.0-test2
Message-Id: <20030731145954.47d6247f.akpm@osdl.org>
In-Reply-To: <Pine.SGI.4.33.0307311058320.17528-100000@ir12.msi.umn.edu>
References: <Pine.SGI.4.33.0307311058320.17528-100000@ir12.msi.umn.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bakos <bakhos@msi.umn.edu> wrote:
>
> Kernel version: 2.6.0-test2
> CPU type: x86-64 (Opteron)
> Problem: Can not successfuly do: make bzImage
> 
> For process.c:
> It says that the file asm/local.h is missing, and errors out in module.h
> at line 175, parse error before local_t

Try test-2-mm2: it has the x86_64 update.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm2/2.6.0-test2-mm2.bz2
