Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUGLLwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUGLLwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 07:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUGLLwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 07:52:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:11689 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266566AbUGLLwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 07:52:04 -0400
Date: Mon, 12 Jul 2004 13:49:48 +0200
From: Olaf Hering <olh@suse.de>
To: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: scripts/kconfig/mconf.c:91: error: static declaration of 'current_menu' follows non-static declaration
Message-ID: <20040712114948.GA9843@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc 3.5 does not like this anymore. 
This is 2.6.8-rc1

GNU C version 3.5.0 20040711 (experimental) (powerpc-unknown-linux-gnu)
        compiled by GNU C version 3.3.3 (SuSE Linux).
GGC heuristics: --param ggc-min-expand=30 --param ggc-min-heapsize=4096
scripts/kconfig/mconf.c:91: error: static declaration of 'current_menu' follows non-static declaration
scripts/kconfig/lkc.h:63: error: previous declaration of 'current_menu' was here


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
