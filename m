Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbTHSVBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTHSUsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:48:46 -0400
Received: from binky.tuxfriends.net ([212.105.197.44]:60686 "EHLO
	binky.tuxfriends.net") by vger.kernel.org with ESMTP
	id S261357AbTHSUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:39:20 -0400
Message-ID: <3F428B91.10804@zaplinski.de>
Date: Tue, 19 Aug 2003 22:41:53 +0200
From: Olaf Zaplinski <olaf@zaplinski.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.0-test3: error compiling tmscsim.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-KAVCheck: binky.tuxfriends.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when trying to compile tmscsim.c (no matter if as module or as builtin), I 
get these errors. module-init-tools is version 0.9.13-pre-0.bunk (Debian 3.0).

Regards
Olaf

In file included from drivers/scsi/tmscsim.c:1825:
drivers/scsi/scsiiom.c:9: #error Please convert me to 
Documentation/DMA-mapping.txt
drivers/scsi/tmscsim.c: In function `dc390_Query_append':
drivers/scsi/tmscsim.c:872: structure has no member named `next'
drivers/scsi/tmscsim.c:877: structure has no member named `next'
drivers/scsi/tmscsim.c: In function `dc390_Query_get':
drivers/scsi/tmscsim.c:889: structure has no member named `next'
drivers/scsi/tmscsim.c:890: structure has no member named `next'
drivers/scsi/tmscsim.c: In function `DC390_waiting_timed_out':
drivers/scsi/tmscsim.c:1074: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c:1078: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c: In function `dc390_BuildSRB':
drivers/scsi/tmscsim.c:1146: structure has no member named `address'
drivers/scsi/tmscsim.c: In function `DC390_abort':
drivers/scsi/tmscsim.c:1564: structure has no member named `next'
drivers/scsi/tmscsim.c:1565: structure has no member named `next'
drivers/scsi/tmscsim.c:1573: structure has no member named `next'
drivers/scsi/tmscsim.c:1575: structure has no member named `next'
drivers/scsi/tmscsim.c:1575: structure has no member named `next'
drivers/scsi/tmscsim.c:1576: structure has no member named `next'
drivers/scsi/tmscsim.c:1584: structure has no member named `next'
drivers/scsi/tmscsim.c:1627: structure has no member named `next'
In file included from drivers/scsi/tmscsim.c:1825:
drivers/scsi/scsiiom.c: In function `DC390_Interrupt':
drivers/scsi/scsiiom.c:267: `DC390_LOCK_IO' undeclared (first use in this 
function)
drivers/scsi/scsiiom.c:267: (Each undeclared identifier is reported only once
drivers/scsi/scsiiom.c:267: for each function it appears in.)
drivers/scsi/scsiiom.c:343: `DC390_UNLOCK_IO' undeclared (first use in this 
function)
drivers/scsi/scsiiom.c:229: warning: unused variable `iflags'
drivers/scsi/scsiiom.c: In function `dc390_DataOut_0':
drivers/scsi/scsiiom.c:384: structure has no member named `address'
drivers/scsi/scsiiom.c: In function `dc390_DataIn_0':
drivers/scsi/scsiiom.c:448: structure has no member named `address'
drivers/scsi/scsiiom.c: In function `dc390_restore_ptr':
drivers/scsi/scsiiom.c:747: structure has no member named `address'
drivers/scsi/scsiiom.c:761: structure has no member named `address'
drivers/scsi/scsiiom.c:764: structure has no member named `address'
drivers/scsi/scsiiom.c: In function `dc390_DataIO_Comm':
drivers/scsi/scsiiom.c:898: structure has no member named `address'
drivers/scsi/scsiiom.c: In function `dc390_SRBdone':
drivers/scsi/scsiiom.c:1373: structure has no member named `address'
drivers/scsi/scsiiom.c:1448: structure has no member named `address'
drivers/scsi/scsiiom.c:1523: structure has no member named `address'
drivers/scsi/scsiiom.c: In function `dc390_RequestSense':
drivers/scsi/scsiiom.c:1764: structure has no member named `address'
drivers/scsi/tmscsim.c: In function `dc390_initAdapter':
drivers/scsi/tmscsim.c:2102: warning: implicit declaration of function 
`request_irq'
drivers/scsi/tmscsim.c: In function `dc390_inquiry':
drivers/scsi/tmscsim.c:2404: request for member `rq_status' in something not 
a structure or union
drivers/scsi/tmscsim.c: In function `dc390_sendstart':
drivers/scsi/tmscsim.c:2455: request for member `rq_status' in something not 
a structure or union
drivers/scsi/tmscsim.c: In function `dc390_set_info':
drivers/scsi/tmscsim.c:2562: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c:2611: `p' undeclared (first use in this function)
drivers/scsi/tmscsim.c:2637: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2639: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2657: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2660: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2663: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2675: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2688: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2726: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c:2733: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c:2745: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c:2753: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c:2759: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2767: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c:2773: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2782: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c:2789: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2797: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c:2804: warning: passing arg 1 of `strsep' makes 
pointer from integer without a cast
drivers/scsi/tmscsim.c:2813: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c:2821: request for member `pScsiHost' in something not 
a structure or union
drivers/scsi/tmscsim.c: In function `DC390_proc_info':
drivers/scsi/tmscsim.c:2935: structure has no member named `next'
drivers/scsi/tmscsim.c: In function `DC390_release':
drivers/scsi/tmscsim.c:3049: warning: implicit declaration of function 
`free_irq'
drivers/scsi/tmscsim.c: At top level:
drivers/scsi/tmscsim.c:3060: `DC390_T' undeclared here (not in a function)
drivers/scsi/tmscsim.c:3061: parse error before `.'
drivers/scsi/tmscsim.c:3036: warning: `DC390_release' defined but not used
drivers/scsi/tmscsim.c:277: warning: `tmscsim_pci_tbl' defined but not used
make[2]: *** [drivers/scsi/tmscsim.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

