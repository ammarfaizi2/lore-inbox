Return-Path: <linux-kernel-owner+w=401wt.eu-S1753113AbWL2Xr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbWL2Xr5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWL2Xr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:47:27 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:45698 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965224AbWL2Xq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:46:58 -0500
Message-Id: <200612292341.kBTNfPGL005524@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 0/6] UML - Locking, whitespace, style, and hotplug fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Dec 2006 18:41:25 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This stuff is all post-2.6.20 material.

I'm fixing the locking through UML, and discovering other nastinesses along
the way.

Patches 1, 4, and 5 fix locking in the console and network drivers.

I have a huge raft of whitespace and style fixes which I will feed in as I
fix the locking in the same files.  The first installment of these are patches
3 and 6.

Patch 2 fixes problems getting hotplug errors back to the host, which I 
discovered while trolling through that code.

				Jeff

