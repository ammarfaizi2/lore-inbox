Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbRE2Jwc>; Tue, 29 May 2001 05:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbRE2JwW>; Tue, 29 May 2001 05:52:22 -0400
Received: from foobar.isg.de ([62.96.243.63]:9487 "HELO newmail.isg.de")
	by vger.kernel.org with SMTP id <S261594AbRE2JwS>;
	Tue, 29 May 2001 05:52:18 -0400
Message-ID: <3B137150.C3F5A77@isg.de>
Date: Tue, 29 May 2001 11:52:16 +0200
From: Constantin Loizides <Constantin.Loizides@isg.de>
Organization: Innovative Software AG
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: inode->i_blksize and inode->i_blocks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

Are there any deeper reasons, 
why
a) inode->i_blksize is set to PAGESIZE eg. 4096 independent of the actual
block size of the file system?

(I suppose, this is for performance reasons (paging), right?)

b) the number of blocks is counted in 512 Bytes and not in the actual blocksize
of the filesystem?

(is this for historical reasons??)

Thx,
Constantin
