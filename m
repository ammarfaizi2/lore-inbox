Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266277AbUFUPiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266277AbUFUPiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUFUPiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:38:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46529 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266274AbUFUPhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:37:23 -0400
Message-ID: <40D700A4.8040708@pobox.com>
Date: Mon, 21 Jun 2004 11:37:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: BK and 'make distclean'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears we have a conflict between what BitKeeper thinks is a source 
file, and what kbuild thinks is a source file:

	[jgarzik@sata linux-2.6]$ bk -r co -Sq
	[jgarzik@sata linux-2.6]$ make distclean
	  CLEAN   scripts/package
	[jgarzik@sata linux-2.6]$ bk -r co -Sq
	[jgarzik@sata linux-2.6]$ make distclean
	  CLEAN   scripts/package

What info can I provide to help debug this?

	Jeff


