Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132053AbRCVP2A>; Thu, 22 Mar 2001 10:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132060AbRCVP1v>; Thu, 22 Mar 2001 10:27:51 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:50185 "HELO
	zcamail05.zca.compaq.com") by vger.kernel.org with SMTP
	id <S132053AbRCVP1j>; Thu, 22 Mar 2001 10:27:39 -0500
Message-ID: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CD10@aeoexc1.aeo.cpqcorp.net>
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: "'Andrea Arcangeli'" <andrea@suse.de>
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: RE: AlphaServer with 4 GB RAM, kernel 2.2.19pre17aa1 patched with
	 big mem... locks for 4 Gbytes, works for 2,6,8 Gbytes
Date: Thu, 22 Mar 2001 16:25:02 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that having a Myrinet 2k board plugged into any slot of the second
PCI bus
of the ES40 make the system freeze with 4 GBytes of RAM when doing cat
/proc/pci.

I just plugged the board back into one slot of PCI 0 and it works again.

Why does it work with Tru64 and not with Linux ? I don't know.

Thanks to Andrea Arcangeli for helping me understand there was something
with the second PCI bus.


----------------------------------------------------------------------------
--
Sebastien CABANIOLS
COMPAQ France 
HPTC Engineer
CustomSystems & Solutions  Annecy  
High Performance Technical Computing 
Office No.  +33 (0)4 50 09 44 10
Fax No.  +33 (0)4 50 64 01 39 
Email.   sebastien.cabaniols@compaq.com 
----------------------------------------------------------------------------
--

  
