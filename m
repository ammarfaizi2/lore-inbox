Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVCFWYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVCFWYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVCFWYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:24:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:24492 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261521AbVCFWYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:24:05 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: swsusp: allow resume from initramfs
Date: Sun, 06 Mar 2005 23:27:37 +0100
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.03.06.22.27.36.378400@dungeon.inka.de>
References: <20050304101631.GA1824@elf.ucw.cz>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great, with this patch I can setup an encrypted swap partition,
and resume from it (after the initramfs asked for the password
and set up the dm-crypt table).

But wait, I'm using swapfiles. swap is fine with files.
what about swsuspend? and if it works with files, too,
what about this resume interface?

Andreas

