Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270255AbRHMPov>; Mon, 13 Aug 2001 11:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270257AbRHMPoi>; Mon, 13 Aug 2001 11:44:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13707 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S270255AbRHMPoZ>;
	Mon, 13 Aug 2001 11:44:25 -0400
Message-ID: <3B77F5CF.5C3CF66D@vnet.ibm.com>
Date: Mon, 13 Aug 2001 15:44:15 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: ppc64 submission
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

  Located on kernel.org in pub/linux/kernel/people/tgall/ you will find 
linuxppc64-2.4.8-1.patch.gz. Please consider this for inclusion into the linux
kernel sources. It applies against 2.4.8 as the name suggests. 

  Included in this patch :
  
  - create and populate arch/ppc64
  - create and populate include/asm-ppc64
  - 1 bug fix to drivers/macintosh/nvram.c (change long declaration to loff_t)
  - 1 fix to drivers/scsi/sr_ioctl.c and drivers/scsi/scsi_scan.c 
      the driver was dma'ing into the stack, the fix changes that to properly
kmalloc

  Future bug fixes, additional patches etc I'll keep in
pub/linux/kernel/people/tgall on kernel.org.

  Information about the ppc64 kernel can be found at linuxppc64.org

  Any questions by all means please hollar!

  Regards,

  Tom
-- 
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
