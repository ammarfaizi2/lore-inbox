Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262661AbREOHBJ>; Tue, 15 May 2001 03:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262665AbREOHBA>; Tue, 15 May 2001 03:01:00 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:12038 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S262662AbREOHAo>; Tue, 15 May 2001 03:00:44 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A4D.00256728.00@d73mta05.au.ibm.com>
Date: Tue, 15 May 2001 12:17:46 +0530
Subject: mmap
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am doing the following:

   malloc some memory is user space
   pass its pointer to some kernel module
   in the kernel module...do a pci_alloc_consistent so that i get a memory
   region for PCI DMA operations

now the problem is that i want to remap the address range pointed by the
user space pointer to the memory region allocated by the
'pci_alloc_consistent' inside the module. I think this is possible..need
some hints....

thanks,
Daljeet Maini
IBM Global Services Ltd. - Bangalore
Ph. No. - 5267117 Extn 2954


