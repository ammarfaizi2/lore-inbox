Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263560AbTDGQX6 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTDGQX6 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:23:58 -0400
Received: from CYRUS.andrew.cmu.edu ([128.2.10.173]:42153 "EHLO
	mail-fe3.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S263560AbTDGQX5 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 12:23:57 -0400
Subject: 2.4.21-pre7 drivers/ide/pci/hpt366.c
From: Steinar Hauan <steinhau+@andrew.cmu.edu>
Reply-To: hauan@cmu.edu
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Carnegie Mellon University
Message-Id: <1049733333.30289.21.camel@steinar.cheme.cmu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 07 Apr 2003 12:35:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from clean unpack + "make oldconfig"

In file included from hpt366.c:70:
hpt366.h:517: `PCI_DEVICE_ID_TTI_HPT372N' undeclared here
[more errors deleted]

--> remapped in to HTP372

PCI_DEVICE_ID_TTI_HPT372N symbol should presumably still be in
 ./include/linux/pci_ids.h, but isnt.

regards,
-- 
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA


