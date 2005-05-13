Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVEMWFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVEMWFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVEMWFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:05:32 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:12447 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262565AbVEMWF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:05:27 -0400
Subject: 2.6.11.x: kernel-8250_pci driver
From: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 13 May 2005 17:02:15 -0500
Message-Id: <1116021735.19302.23.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-13) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I would like to request some help from the device drivers experts.
The 8250_pci driver has pci_boards[] array, enumeration constants (enum
pci_board_num_t) and also pci_serial_quirk[] array for storing the data
of PCI boards from various vendors such as HP, Intel etc.,

  Should the order of data in the pci_boards[] array and
pci_serial_quirk[] be according to the enumeration constants ordered in
the pci_board_num_t ?  

  The procedure 
	static int __devinit pciserial_init_one(struct pci_dev *dev, const
struct pci_device_id *ent)
  has the dev and ent structures to hold info on a given PCI board. When
and where from these variables get their data?  Can some one help me by
answering the above two questions?  I could not get much info from the
documentation or the Device Drivers book.  Thanks in advance.

V. Ananda Krishnan

 

