Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266447AbUANXsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266458AbUANXsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:48:37 -0500
Received: from smtp12.eresmas.com ([62.81.235.112]:44522 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S266447AbUANXrp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:47:45 -0500
Message-ID: <4005D4B4.1000705@wanadoo.es>
Date: Thu, 15 Jan 2004 00:45:56 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: [summary] state of scsi drivers
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        * unofficial 2.4 LiNUX kernel SCSI/RAID drivers list *

                        <xose@wanadoo.es>

                         linux-2.4.25-pre4+BK
                     Thu Jan 15 00:27:20 CET 2004


x features:
    64_bit_SG block_device_driver highmem_io hot-plug vary_io

o aacraid
   manufacturer: ADAPTEC
   kernel: 1.1.2 (15 May 2003)
   latest: 1.1.4 (23 Dec 2003)
   arch: i386 ia64 x86_64 alpha (sparc not confirmed, but expected)
   features: 64_bit_SG highmem_io vary_io
   maintainer: <Mark_Salyzyn*AT*adaptec.com> <aacraid*AT*adaptec.com>
   url: http://linux.adaptec.com
        http://linux.dell.com/raid.shtml#aacraid
   ml: http://lists.us.dell.com/mailman/listinfo/linux-aacraid-devel

o aic7xxx/aic79xx
   manufacturer: ADAPTEC
   kernel: 6.2.36/1.3.10 (03 Jun 2003)
   latest: 6.3.4 /2.0.5  (22 Dec 2003)
   arch: i386 ia64 powerpc
   features: highmem_io vary_io
   maintainer: kernel nobody - vendor <gibbs*AT*scsiguy.com>
   url: http://people.freebsd.org/~gibbs/linux/SRC/
   ml: http://lists.freebsd.org/mailman/listinfo/aic7xxx

o cciss
   manufacturer: HP
   kernel: 2.4.50
   latest: 2.4.50
   arch: i386
   features: block_device_driver highmem_io vary_io
   maintainer: <mike.miller*AT*hp.com> <arrays*AT*hp.com>
   url: http://sf.net/projects/cciss/

o DAC960
   manufacturer: LSI Logic
   kernel: 2.4.11 (11 Oct 2001)
   latest: 2.4.20 (01 May 2003)
   arch: i386 ia64 alpha
   features: block_device_driver highmem_io
   maintainer: <dmo*AT*osdl.org>
   url: http://www.osdl.org/archive/dmo/DAC960/
        http://www.dandelion.com/Linux/DAC960.html

o dpt_i2o
   manufacturer: ADAPTEC
   kernel: 2.4.5 (25 Jul 2001)
   latest: 2.5.0 (11 Sep 2003)
   arch: i386 ia64 alpha sparc x86_64
   features: 64_bit_SG highmem_io
   maintainer: <Mark_Salyzyn*AT*adaptec.com>
   url: http://linux.adaptec.com

o emulex
   manufacturer: EMULEX
   kernel: -
   latest: 1.23a
   arch: i386 ia64 ppc
   features:
   maintainer: vendor <tech.support*AT*emulex.com>
   url: http://www.emulex.com/ts/docfc/linuxos.shtml

o feral_isp
   manufacturer: QLOGIC
   kernel: -
   latest: Linux Platform 2.1 Common Core Code 2.7 (13 Nov 2003)
   arch: i386 alpha sparc powerpc
   features:
   maintainer: external <mjacob*AT*feral.com>
   url: http://www.feral.com/isp.html

o fusion
   manufacturer: LSI Logic
   kernel: 2.05.05+ (14 Apr 2003)
   latest: 2.05.11  (09 Jan 2004)
   arch: i386 alpha sparc ia64 x86_64
   features: highmem_io vary_io
   maintainer: <emoore*AT*lsil.com> <mpt_linux_developer*AT*lsil.com>
   url: ftp://ftp.lsil.com/HostAdapterDrivers/linux/Fusion-MPT/

o gdth
   manufacturer: ADAPTEC
   kernel: 2.05  (03 Oct 2002)
   latest: 2.06a (04 Aug 2003)
   arch: i386 alpha ia64
   features:
   maintainer: <achim_leubner*AT*adaptec.com>
   url: http://www.icp-vortex.com/english/download/rz_neu/linux/linux_e.htm

o ips
   manufacturer: ADAPTEC
   kernel: 6.10.24
   latest: 6.10.24
   arch: i386 ia64 x86_64
   features: highmem_io
   maintainer: <david_jeffery*AT*adaptec.com> <jack_hammer*AT*adaptec.com>
               <ipslinux*AT*adaptec.com>

o megaraid
   manufacturer: LSI Logic
   kernel: v1.18k/v2.00.9 (Sep 04, 2003)
   latest: v1.18k/v2.10.1 (Dec 03, 2003)
   arch: i386
   features: highmem_io vary_io
   maintainer: <atulm*AT*lsil.com>
   url: ftp://ftp.lsil.com/pub/linux-megaraid/
        http://linux.dell.com/raid.shtml#megaraid

o qla1280
   manufacturer: QLOGIC
   kernel: 3.23.37
   latest: 3.23.37
   arch: i386 alpha
   features:
   maintainer: <jes*AT*wildopensource.com>

o qla2x00
   manufacturer: QLOGIC
   kernel: -
   latest: 6.06.10   (06 Oct 2003)
   beta:   8.00.00b9 (13 Jan 2004)
   arch: i386
   features:
   maintainer: vendor <andrew.vasquez*AT*qlogic.com>
   url: http://www.qlogic.com/support/product_resources.asp?id=339
        http://sf.net/projects/linux-qla2xxx/

o sym53c8xx_2
   manufacturer: LSI Logic
   kernel: 2.1.17a     (Dec 01 2001)
   latest: 2.1.19-pre3 (Nov 23 2002)
   arch: i386 alpha sparc powerpc ia64
   features:
   maintainer: nobody
   url: http://www.tux.org/pub/tux/roudier/drivers/linux/stable/

# EOT

