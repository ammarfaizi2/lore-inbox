Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262710AbREOJpw>; Tue, 15 May 2001 05:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262713AbREOJpm>; Tue, 15 May 2001 05:45:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46606 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262712AbREOJpf>; Tue, 15 May 2001 05:45:35 -0400
Subject: Re: mmap
To: mdaljeet@in.ibm.com
Date: Tue, 15 May 2001 10:42:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <CA256A4D.00256728.00@d73mta05.au.ibm.com> from "mdaljeet@in.ibm.com" at May 15, 2001 12:17:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zbLD-0002H9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> now the problem is that i want to remap the address range pointed by the
> user space pointer to the memory region allocated by the
> 'pci_alloc_consistent' inside the module. I think this is possible..need
> some hints....

Wrong way around. Ask the device to create its mapping and reply with the size
mmap the object

