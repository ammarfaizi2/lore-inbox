Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273240AbRIRJUA>; Tue, 18 Sep 2001 05:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273253AbRIRJTv>; Tue, 18 Sep 2001 05:19:51 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:61376 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S273240AbRIRJTj>; Tue, 18 Sep 2001 05:19:39 -0400
Message-ID: <3BA710EF.FC38A28B@rcn.com.hk>
Date: Tue, 18 Sep 2001 17:16:31 +0800
From: David Chow <davidchow@rcn.com.hk>
Organization: Resources Computer Network Ltd.
X-Mailer: Mozilla 4.76 [zh_TW] (X11; U; Linux 2.4.4-1DC i686)
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: EFAULT from file read.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am having trouble in reading a file in the kernel space using the
file->f_op->read call, everything is ok. I start off file->f_pos = 0 . I
also did a mntget to the super block before I call
"file=dentry_open(.....)" . I intend to open the file in read only mode.
What can be wrong? I have also check the inode->i_size is large enough
for me to just read 8 bytes from the file. I keep having EFAULT error
from the read call... also before calling mntget, also did a dget to the
dentry. Any help is welcomed. Thanks.

regards,

David Chow
