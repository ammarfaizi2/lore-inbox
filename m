Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133024AbRD3SPa>; Mon, 30 Apr 2001 14:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135222AbRD3SPT>; Mon, 30 Apr 2001 14:15:19 -0400
Received: from web6101.mail.yahoo.com ([128.11.22.95]:28434 "HELO
	web6101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S133024AbRD3SPQ>; Mon, 30 Apr 2001 14:15:16 -0400
Message-ID: <20010430181513.4255.qmail@web6101.mail.yahoo.com>
Date: Mon, 30 Apr 2001 11:15:13 -0700 (PDT)
From: Patrick Allaire <xaqc@yahoo.com>
Subject: I2O behaviour ...
To: linux-kernel@vger.kernel.org
Cc: patrick.allaire@isaacnewtontech.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is my first post on this list, I have been reading you all for
quite a while. But now I have my Module to do...

I have compiled the kernel (2.2.19) with I2O support, but when I try
to compile my module, I get an unresolved error with the :
i2o_pci_scan function. Is there a special way to compile the kernel
to get those calls ?

If I do a : cat /proc/ksyms, I get a bunch of I20 functions but I
dont have :
i2o_pci_scan
i2o_pci_install ... 
those functions are defined in drivers/i2o/i2o_pci.c

Here is a short description of what I need to do. I have a host PC
and a local PC, both a separated by an INTEL (DEC) 21554. This is a
non-transparent pci-to-pci bridge. I need to do a module for both
computer to make them communicate by the mean of the PCI. The 21554
is supporting I2O. Maybe I am not at all going in the right direction
... If can someone point me out in this good direction !

Thank for your time and help.

=====
________________________________
Patrick Allaire
mailto:pallaire@bigfoot.com

#define QUESTION ((bb) || !(bb)) 
    - Shakespeare.
________________________________

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
