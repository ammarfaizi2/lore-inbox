Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263113AbREaRBS>; Thu, 31 May 2001 13:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263115AbREaRBJ>; Thu, 31 May 2001 13:01:09 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:9265 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S263113AbREaRAy>; Thu, 31 May 2001 13:00:54 -0400
Date: Thu, 31 May 2001 18:58:41 +0200
Message-Id: <200105311658.f4VGwfX02382@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs_read_inode2
In-Reply-To: <877710000.991317458@tiny>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: E233 4EB2 BC46 44A7 C5FC  14C7 54ED 2FE8 FEB9 8835
X-Key-ID: 829B1533
User-Agent: tin/1.5.9-20010522 ("Blue Water") (UNIX) (Linux/2.4.5 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <877710000.991317458@tiny> you wrote:
>> portraits:~# dmesg
>> vs-13042: reiserfs_read_inode2: [2299 593873 0x0 SD] not found
>> vs-13048: reiserfs_iget: bad_inode. Stat data of (2299 593873) not found
>> vs-13042: reiserfs_read_inode2: [2299 593807 0x0 SD] not found
>> vs-13048: reiserfs_iget: bad_inode. Stat data of (2299 593807) not found
>> 
>> 2.4.5 with lock_kernel/unlock patch,reiserfsprogs 3.x.0h, RH 7.1

> In this case, it probably means you are serving NFS from that disk, which
> needs extra patches.  Are you?

No. There is news spool and squid spool - not available by NFS.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
