Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUGSUEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUGSUEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 16:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbUGSUEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 16:04:53 -0400
Received: from quechua.inka.de ([193.197.184.2]:44432 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265490AbUGSUEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 16:04:51 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: Ramdisk encryption
Date: Mon, 19 Jul 2004 22:15:02 +0200
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2004.07.19.20.15.02.206401@dungeon.inka.de>
References: <951A499AA688EF47A898B45F25BD8EE80126D4C9@mailer.nec-labs.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you are looking for disk encryption.
take a look at dm-crypt. the kernel
will read the encrypted partition, decrypt,
run the software, and if you write data,
before writing it, the kernel will encrypt
it.

you don't need a ramdisk for that.

Andreas

