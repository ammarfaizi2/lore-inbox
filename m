Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbTLCTnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 14:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbTLCTnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 14:43:24 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:33156 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S265117AbTLCTnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:43:22 -0500
From: Daniel Flinkmann <DFlinkmann@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: RE: PROBLEM: Corrupt files with kernel 2.6.0_test11 and smb mounts
Date: Wed, 3 Dec 2003 20:06:37 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312032006.37919.DFlinkmann@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have rebuild the kernel several times to check if I can get my kernel 
running with SMB like Kieran, but no luck up to now.

I found following Warning which concerns me:

[...]

  CC      fs/smbfs/inode.o
fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:554: warning: comparison is always false due to limited range 
of data type
fs/smbfs/inode.c:555: warning: comparison is always false due to limited range 
of data type
  CC      fs/smbfs/file.o
  CC      fs/smbfs/ioctl.o
  CC      fs/smbfs/getopt.o
  CC      fs/smbfs/symlink.o
  CC      fs/smbfs/smbiod.o
  CC      fs/smbfs/request.o
  LD      fs/smbfs/smbfs.o
  LD      fs/smbfs/built-in.o
[...]

Please help me ... even if you just know who I should ask in that question.

cheers,

daniel

