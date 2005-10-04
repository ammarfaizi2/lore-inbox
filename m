Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVJDGQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVJDGQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 02:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbVJDGQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 02:16:50 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:7316 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932364AbVJDGQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 02:16:49 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: [RFC PATCH] pci_ids: cleanup - remove redundant #defines from source
Date: Tue, 04 Oct 2005 16:16:10 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <o074k19ojpqntrdhv3t3treul4hp9a45if@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Appended is start of next set for pci_ids cleanup.

RFC as the pci_ids cleanup after this patch will involve transferring 
symbols from source to pci_ids.h.  The files in this patch are part of 
a 49 file target list that contain an #ifndef, #define sequence for 
PCI_VENDOR_ID_* and PCI_DEVICE_ID_* symbols.  Remaining targets require 
a transfer of symbols to pci_ids.h, thus will be presented separately 
by areas identified from linux/MAINTAINERS.

Further information (eg. hit list) is on:
  http://bugsplatter.mine.nu/kernel/pci_ids/

Cheers,
Grant.

