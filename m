Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSG2LJA>; Mon, 29 Jul 2002 07:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSG2LJA>; Mon, 29 Jul 2002 07:09:00 -0400
Received: from webmail25.rediffmail.com ([203.199.83.147]:16788 "HELO
	webmail25.rediffmail.com") by vger.kernel.org with SMTP
	id <S315179AbSG2LI7>; Mon, 29 Jul 2002 07:08:59 -0400
Date: 29 Jul 2002 11:12:38 -0000
Message-ID: <20020729111238.11416.qmail@webmail25.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel crash in fault.c
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I am getting a kernel crash when i try to load (using insmod) my
driver module into the kernel.
When the kernel boots up, it identifies my device (hardware
device) and allocates memory and fixup irq for that.
Mean while in driver i am registering the driver using,
pci_register_driver. When i tried to access (write a word) the 
PCI
memory space allocated for my device, the kernel crashes saying
"Unable to handle kernel paging request at virtual address "
in fault.c function : do_page_fault?

Can anyone throw a light on this?

Thanks in advance,
Nanda.

