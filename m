Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264421AbRFOO7h>; Fri, 15 Jun 2001 10:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264422AbRFOO71>; Fri, 15 Jun 2001 10:59:27 -0400
Received: from t111.niisi.ras.ru ([193.232.173.111]:55138 "EHLO
	t111.niisi.ras.ru") by vger.kernel.org with ESMTP
	id <S264421AbRFOO7M>; Fri, 15 Jun 2001 10:59:12 -0400
Message-ID: <3B2A0F05.6050902@niisi.msk.ru>
Date: Fri, 15 Jun 2001 17:35:01 +0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Using cramfs as root filesystem on diskless machine
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, list.

My MIPS machine has no any disks or flopies. So i obliged to use a RAM
disk with a file system on it, which is mounted as root.
I use gzipped initrd image, which is linked to the special section in the
kernel during compilation. Now, the RAM disk size is really big, so i 
decide
to use cramfs instead of ext2. In scripts/cramfs/ I found an utility that
creates cramfs file system image. But i read in rd.c, that RAM disk driver
doesn't support the cramfs.

After i create an image, how can i mount it as root file system? Where i
must put it? Which kernel command line options i must use?

Please answer, or point me to any documentation or mailing list.

