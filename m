Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTHJKuP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 06:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTHJKuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 06:50:15 -0400
Received: from coderock.org ([193.77.147.115]:5386 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262439AbTHJKuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 06:50:12 -0400
From: Domen Puncer <domen@coderock.org>
To: gerhard@gjaeger.de
Subject: [PATCH] Plustek scanner driver (pt_drv) port to 2.6
Date: Sun, 10 Aug 2003 12:50:12 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308101250.12481.domen@coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a Plustek scanner, so i "ported" scanner driver
http://www.gjaeger.de/scanner/plustek.html to 2.6.0-test2 kernel.

The patch is at:
http://coderock.org/kernel/plustek-0.45-2.6.0-test2.diff

Usage:
wget http://www.gjaeger.de/scanner/current/plustek-sane-0.45-5.tar.gz
tar xvzf plustek-sane-0.45-5.tar.gz
cd backend/plustek_driver
wget http://coderock.org/kernel/plustek-0.45-2.6.0-test2.diff
patch -p2 -i plustek-0.45-2.6.0-test2.diff
make

Tip: you can still use old makefile with make -f Makefile.old


TODO:
Someone who knows Makefiles should make a user friendly one (or port the old 
Makefile).


	Domen
