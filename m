Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVAAPi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVAAPi6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 10:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVAAPi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 10:38:57 -0500
Received: from quechua.inka.de ([193.197.184.2]:26290 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261697AbVAAPit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 10:38:49 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: initramfs: is it supposed to work?
Date: Sat, 01 Jan 2005 16:40:13 +0100
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.01.01.15.40.12.264342@dungeon.inka.de>
References: <41D4A2A6.3060607@tls.msk.ru> <cr319b$31b$1@terminus.zytor.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

run-init seems to mount the new root, rm files in the old root,
mount, chroot, open the console, exec. any reason we can't do
that in shell script commands?
 
> You don't pivot_root initramfs, because initramfs *IS* rootfs.
> 
> Instead, use the run-init program

ok, but still: is it ok for the kernel to die?
after all pivot_root works fine, unless /initrd is unmounted.
what exactly is the kernel internal that makes pivot_root special?

Regards, Andreas

