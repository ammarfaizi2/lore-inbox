Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSFYNVr>; Tue, 25 Jun 2002 09:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSFYNVq>; Tue, 25 Jun 2002 09:21:46 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:63178 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S315463AbSFYNVq>; Tue, 25 Jun 2002 09:21:46 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793954@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Question concerning PCI device driver
Date: Tue, 25 Jun 2002 09:21:46 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have written a device driver for a cPCI board which is currently running
under a 2.2 Kernel. When I load the driver via insmod, I register it it as a
CHRDEV to get the major number assigned dynamically. My application uses
this to build the node dynamically whenever it is started. This provides a
clean interface for IOCTL commands. 

I am now porting this driver to a 2.4 Kernel and in the Linux device driver
book it talks about using pci_module_init. How do I get the major number to
allow for IOCTL commands? Or alternatively is there a different way to
interface IOCTL's to a PCI driver. By the way the board is not a network
interface but a very specialized 8 bit serial interface. Please CC me
directly in any responses.


Thanks in advance.

Jack Bloch
Siemens Carrier Networks
e-mail    : jack.bloch@icn.siemens.com
phone     : (561) 923-6550

