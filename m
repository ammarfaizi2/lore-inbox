Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVFNVKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVFNVKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVFNVKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:10:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36296 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261337AbVFNVKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:10:18 -0400
Subject: serial port driver 8250_pci - pci_device_id structure
From: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de
Content-Type: text/plain
Date: Tue, 14 Jun 2005 16:05:40 -0500
Message-Id: <1118783140.7069.12.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-13) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

  In ppc architecture, I am trying to find out the codes that populate
the pci_devic_id structure ( drivers/serial/8250_pci.c file) in the
following init_one function:

static int __devinit
pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)


  I have the (pci card) data hard-coded in the following tables of
8250_pci.c file:
          static struct pci_device_id serial_pci_tbl[]
          static struct pci_board pci_boards[] __devinitdata={...}


Since I could not find the data in the pci_device_id for pci card, I
went thru the drivers/pci/search.c and drivers/pci/pci-driver.c files. I
am not successful in locating those codes that populate the
pci_device_id structure for a given pci card.

Could some one let me know where I go wrong or where I have to look for
the codes?

Thanks,
V. Ananda Krishnan

