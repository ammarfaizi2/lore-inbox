Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbTKKPYl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTKKPYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:24:41 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:24981 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id S263545AbTKKPYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:24:38 -0500
Date: Tue, 11 Nov 2003 16:24:37 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] 2.6.0-test9 smsc-ircc2.c
Message-ID: <20031111152437.GA31407@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo l-k,

I've found bug in the smsc-ircc2.c. Patch is attached.

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="smsc-ircc2.c.diff"

--- linux-2.6.0-test9/drivers/net/irda/smsc-ircc2.c	2003-10-25 20:43:57.000000000 +0200
+++ linux-2.6.0-test9-new/drivers/net/irda/smsc-ircc2.c	2003-11-05 23:07:37.000000000 +0100
@@ -524,7 +524,7 @@
 
 	return 0;
  out3:
-	release_region(fir_base, SMSC_IRCC2_FIR_CHIP_IO_EXTENT);
+	release_region(sir_base, SMSC_IRCC2_SIR_CHIP_IO_EXTENT);
  out2:
 	release_region(fir_base, SMSC_IRCC2_FIR_CHIP_IO_EXTENT);
  out1:

--9amGYk9869ThD9tj--
