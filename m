Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264477AbRFOSat>; Fri, 15 Jun 2001 14:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264476AbRFOSan>; Fri, 15 Jun 2001 14:30:43 -0400
Received: from [199.111.154.8] ([199.111.154.8]:18698 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S264477AbRFOSa3>; Fri, 15 Jun 2001 14:30:29 -0400
Message-ID: <3B2A538A.BA62148A@linuxjedi.org>
Date: Fri, 15 Jun 2001 14:27:22 -0400
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexandr Andreev <andreev@niisi.msk.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Using cramfs as root filesystem on diskless machine
In-Reply-To: <3B2A0F05.6050902@niisi.msk.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathias Killian wrote a patch to allow cramfs initrd's, see:
http://www.cs.helsinki.fi/linux/linux-kernel/2001-01/1064.html

Alexandr Andreev wrote:
> 
> Hi, list.
> 
> My MIPS machine has no any disks or flopies. So i obliged to use a RAM
> disk with a file system on it, which is mounted as root.
> I use gzipped initrd image, which is linked to the special section in the
> kernel during compilation. Now, the RAM disk size is really big, so i
> decide
> to use cramfs instead of ext2. In scripts/cramfs/ I found an utility that
> creates cramfs file system image. But i read in rd.c, that RAM disk driver
> doesn't support the cramfs.
> 
> After i create an image, how can i mount it as root file system? Where i
> must put it? Which kernel command line options i must use?
> 
> Please answer, or point me to any documentation or mailing list.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
David L. Parsley
Network Administrator, Roanoke College
"If I have seen further it is by standing on ye shoulders of
Giants."
--Isaac Newton
