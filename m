Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263021AbTC1Ppi>; Fri, 28 Mar 2003 10:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263022AbTC1Pph>; Fri, 28 Mar 2003 10:45:37 -0500
Received: from dsl-24293-ld.customer.centurytel.net ([209.142.135.135]:53793
	"EHLO CopelandConsulting.Net") by vger.kernel.org with ESMTP
	id <S263021AbTC1Ppc>; Fri, 28 Mar 2003 10:45:32 -0500
X-Trade-Id: <CCC.Fri, 28 Mar 2003 09:56:43 -0600 (CST).Fri, 28 Mar 2003 09:56:43 -0600 (CST).200303281556.h2SFug730883.h2SFug730883@CopelandConsulting.Net.
Subject: 2.5.65 7880 SCSI bug
From: Greg Copeland <gtcopeland@earthlink.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048867005.2304.4.camel@mouse.copelandconsulting.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 28 Mar 2003 09:56:45 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Asus P2L97-DS motherboard.  It has two PII-333 in it.  I'm
using the onboard SCSI interface, which is a 7880 (U).  I have 5-SCSI
drives (combination of wide and narrow), a SCSI CDROM and a SCSI tape
drive.  The drives have ID's 0-6 while the interface has ID 7.

When attempting to boot 2.5.65 or 2.5.64, neither is able to get past
SCSI initialization.  It simply loops and never completes a boot cycle. 
I have tried both the "newer" Adaptec AIC7xxx Fast -> U160 support (New
Driver) and the older Adaptec AIC7xxx support (old driver).  Both
experience the same behavior.

I'm currently running 2.4.19 and this system has been working, more or
less as is, since the mid 2.2-days.


Best Regards,

Greg Copeland




