Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVCFWaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVCFWaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVCFWaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:30:19 -0500
Received: from quechua.inka.de ([193.197.184.2]:33964 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261555AbVCFWaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:30:08 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: swsusp: allow resume from initramfs
Date: Sun, 06 Mar 2005 23:28:36 +0100
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.03.06.22.28.35.805021@dungeon.inka.de>
References: <20050304101631.GA1824@elf.ucw.cz> <20050304030410.3bc5d4dc.akpm@osdl.org>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Mar 2005 11:35:12 +0000, Andrew Morton wrote:
> I don't understand how this can be affected by the modularness of the
> kernel.  Can you explain a little more?
> 
> Would it not be simpler to just add "resume=03:02" to the boot command line?

initramfs can also be used to ask for a passphrase, hash it, and setup
some (de)cryption dm tables.

Andreas

