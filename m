Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWFIBED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWFIBED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWFIBED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:04:03 -0400
Received: from hermes.hosts.co.uk ([212.84.175.24]:15530 "EHLO
	pallas.hosts.co.uk") by vger.kernel.org with ESMTP id S965068AbWFIBEC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:04:02 -0400
To: <linux-kernel@vger.kernel.org>
CC: <torvalds@osdl.org>
From: =?utf-8?q?=22Felix=20Oxley=22?= <lkml@oxley.org>
Reply-To: =?utf-8?q?=22Felix=20Oxley=22?= <lkml@oxley.org>
Subject: =?utf-8?q?2=2e6=2e17=2drc6=3a=20Fails=20to=20compile=20on=20PowerBook?=
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <E1FoVPv-00059c-HM@mercury.hosts.co.uk>
Date: Fri, 09 Jun 2006 02:04:03 +0100
X-Spam-Score: -4.4 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suse 10.1:

  CC      mm/util.o
  CC      mm/mmzone.o
  CC      mm/fremap.o
  LD      mm/built-in.o
  CC [M]  fs/configfs/inode.o
objdump: 'fs/configfs/.tmp_inode.o': No such file
mv: cannot stat `fs/configfs/.tmp_inode.o': No such file or directory
make[2]: *** [fs/configfs/inode.o] Error 1
make[1]: *** [fs/configfs] Error 2
make: *** [fs] Error 2

//felix
