Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTJ3KMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 05:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTJ3KMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 05:12:35 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:52449 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262328AbTJ3KMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 05:12:34 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: BUG? gcc says comparison always false in fs/smbfs/inode.c
Date: Thu, 30 Oct 2003 11:12:47 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310301112.47534@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

can someone who knows the code please have a look at this warning from my
gcc 3.3:

  CC [M]  fs/smbfs/inode.o
/mnt/kernel/linux-2.6.0-test9-eike/fs/smbfs/inode.c:
	In function `smb_fill_super':
/mnt/kernel/linux-2.6.0-test9-eike/fs/smbfs/inode.c:554:
	warning: comparison is always false due to limited range of data type
/mnt/kernel/linux-2.6.0-test9-eike/fs/smbfs/inode.c:555:
	warning: comparison is always false due to limited range of data type

Eike
