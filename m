Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbREMPjz>; Sun, 13 May 2001 11:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbREMPjo>; Sun, 13 May 2001 11:39:44 -0400
Received: from ip-9-199-65-202.speed-link.com.hk ([202.65.199.9]:900 "HELO
	desktop.carfield.com.hk") by vger.kernel.org with SMTP
	id <S261412AbREMPja>; Sun, 13 May 2001 11:39:30 -0400
Message-ID: <3AFEABC4.BA46A1B@programmer.net>
Date: Sun, 13 May 2001 23:44:04 +0800
From: Carfield Yim <carfield@programmer.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can't read the CDRW disc created in Windows.
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't read the CDRW disc created in Windows.
If I use:
mount -t udf /dev/scd1 /mnt/cdrw

It will report:
mount: wrong fs type, bad option, bad superblock on /dev/scd1, or too
many mounted file systems

If I use:
mount -t auto /dev/scd1 /mnt/cdrw

Then I can success mount with type iso9660, but the display file is not
correct, because it is not iso9660:
[root@desktop cdrw]# ls
autorun.inf*  udfrinst.exe*

I suppose the file system of CDRW in UDF, as state in kernel doc. Why I
can't mount it??

P.S.: I have try to put a Data CD in that CDRW driver to test, it can
show the correct files in it, so I think the problem is UDF in linux, do
anyone have any idea about this issue?
-- 



Carfield Yim, visit my homepage at http://www.carfield.com.hk
