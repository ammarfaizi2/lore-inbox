Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbUL0To3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbUL0To3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbUL0To3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:44:29 -0500
Received: from f16.mail.ru ([194.67.57.46]:30476 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S261954AbUL0ToV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:44:21 -0500
From: Samium Gromoff <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: gen_init_cpio vs. symlink support
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 192.168.1.102 via proxy [80.92.98.198]
Date: Mon, 27 Dec 2004 22:44:18 +0300
Reply-To: Samium Gromoff <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1Cj0mw-0006y3-00._deepfire-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It sucks that gen_init_cpio treats symlinks as regular files. 
It is even dictated by the initramfs format description which has no 
special case for symlinks. 
 
Makes the whole thing useless for some major scenarios. 
 
regards, Samium Gromoff 
