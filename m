Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBLWg2>; Mon, 12 Feb 2001 17:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131635AbRBLWgS>; Mon, 12 Feb 2001 17:36:18 -0500
Received: from agrashak.cpg.com.au ([138.79.128.10]:13829 "HELO
	agrashak.cpg.com.au") by vger.kernel.org with SMTP
	id <S131556AbRBLWgG>; Mon, 12 Feb 2001 17:36:06 -0500
Message-ID: <3A886654.93BEAE4@cpgen.cpg.com.au>
Date: Tue, 13 Feb 2001 09:40:20 +1100
From: Grahame Jordan <jordg@cpgen.cpg.com.au>
Organization: Interim Technology Training Institute
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, support@supermicro.com
Subject: Machine Freeze
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!,

We have several machines running Supermicro 370DLE motherboad with dual
733MHz Processors.
We are running reiserfs on some partitions.  2 x 9.1GB SCSI HDD and 1 x
18GB SCSI HDD.
Kernel 2.2.18

Every so often the machines freezes, possibly whilst we are rsyncing to
the machine, but it does not
freeze every day.

Error messages copied from the screen:
Freeze 1
kmem_alloc: Bad slab magic (corrupt)
cname=skbuff_head_cache

Freeze 2
unable to handle kernel NULL pointer dereference at virtual address
00000000
current tss.cr3=140C9000 %cr3-140e9000 *pde=00000000
Opps=0002
Cpu=1
EIP=00/0=[,c0136130>]
EFLAGS=00010246
eax: ebx ecx etc
Process rsync (pid=1728, process nr=90, stackpage=d41d9000)

In both of these the kernel was corrupt on the boot sector and had to
use a floppy to boot. Rerun lilo it is OK.

Thanks


--
Grahame Jordan
Network Manager - Consumer, Education
Spherion Group Limited

1st Floor, 493 St Kilda Rd, Melbourne VIC 3004
Tel: 61 3 9243 2220   Mobile: 61 3 408 058 209   Fax: 61 3 9820 2010
grahamejordan@spherion.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
