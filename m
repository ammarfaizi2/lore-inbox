Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSCSUrB>; Tue, 19 Mar 2002 15:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292688AbSCSUqw>; Tue, 19 Mar 2002 15:46:52 -0500
Received: from bnathan.remote.ics.uci.edu ([128.195.36.177]:25587 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S292666AbSCSUqo>; Tue, 19 Mar 2002 15:46:44 -0500
Subject: Re: New IBM IDE drive recognized as 40 GB but is 80 GB
To: Martin.Rode@zeroscale.com (Martin Rode)
Date: Tue, 19 Mar 2002 12:47:10 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Martin Rode" at Mar 19, 2002 09:02:29 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020319204710.F37AD89548@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have bought a new IDE hard drive:
> 
> hdb: IC35L040AVVA07-0, ATA DISK drive
             ^^ 40GB (well, according to IBM, "41.17GB")

Look here if you don't believe me:
http://www.storage.ibm.com/hdd/support/d120gxp/d120gxpmod.htm
 
> This is wrongly recognized as 40GB (should be 80GB) drive:
[snip]
> [root@apu /root]# cat /proc/ide/hdb/capacity
> 80418240           <--------------------------------- this is correct
> [root@apu /root]#
> 
> shows the right capacity.

80418240 512-byte sectors is about 40GB.

The kernel is reporting the correct size... 40GB.

-Barry K. Nathan <barryn@pobox.com>
