Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267876AbTBRQ5g>; Tue, 18 Feb 2003 11:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267877AbTBRQ5g>; Tue, 18 Feb 2003 11:57:36 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:42001 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267876AbTBRQ5e>; Tue, 18 Feb 2003 11:57:34 -0500
Date: Tue, 18 Feb 2003 18:07:34 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [TRIVIAL][PATCH][RESEND]
Message-ID: <Pine.LNX.4.51.0302181806080.19871@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

two typo patches:

Regards,
Maciej Soltysiak

*** linux-2.5.60/drivers/atm/firestream.c~	Mon Feb 10 19:37:59 2003
--- linux-2.5.60/drivers/atm/firestream.c	Mon Feb 17 20:49:32 2003
***************
*** 1792,1798 ****
  		write_fs (dev, RAC, 0);

  		/* Manual (AN9, page 6) says ASF1=0 means compare Utopia address
! 		 * too.  I can't find ASF1 anywhere. Anyway, we AND with just hte
  		 * other bits, then compare with 0, which is exactly what we
  		 * want. */
  		write_fs (dev, RAM, (1 << (28 - FS155_VPI_BITS - FS155_VCI_BITS)) - 1);
--- 1792,1798 ----
  		write_fs (dev, RAC, 0);

  		/* Manual (AN9, page 6) says ASF1=0 means compare Utopia address
! 		 * too.  I can't find ASF1 anywhere. Anyway, we AND with just the
  		 * other bits, then compare with 0, which is exactly what we
  		 * want. */
  		write_fs (dev, RAM, (1 << (28 - FS155_VPI_BITS - FS155_VCI_BITS)) - 1);


*** drivers/s390/block/dasd_3990_erp.c~	Mon Feb 25 20:38:03 2002
--- drivers/s390/block/dasd_3990_erp.c	Sat Feb 15 21:10:56 2003
***************
*** 2809,2815 ****
   *     - exit with permanent error
   *
   * PARAMETER
!  *   erp                ERP which is in progress wiht no retry left
   *
   * RETURN VALUES
   *   erp                modified/additional ERP
--- 2809,2815 ----
   *     - exit with permanent error
   *
   * PARAMETER
!  *   erp                ERP which is in progress with no retry left
   *
   * RETURN VALUES
   *   erp                modified/additional ERP

