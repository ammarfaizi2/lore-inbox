Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUHaLry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUHaLry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 07:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUHaLry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 07:47:54 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:39633 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S267882AbUHaLrx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 07:47:53 -0400
From: Duncan Sands <baldrick@free.fr>
To: linux-kernel@vger.kernel.org
Subject: external modules make clean doesn't do much
Date: Tue, 31 Aug 2004 13:47:52 +0200
User-Agent: KMail/1.6.2
Cc: sam@ravnborg.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408311347.52754.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make clean for an external module only seems to clean
.tmp_versions:

$ make clean
make -C /lib/modules/2.6.9-rc1/build M=`pwd` clean
make[1]: Entering directory `/home/duncan/Linux/linux-2.5'
  CLEAN   /home/duncan/SpeedTouch/.tmp_versions
make[1]: Leaving directory `/home/duncan/Linux/linux-2.5'
$

This leaves all the .o etc files which doesn't sound right...

All the best,

Duncan.
