Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135304AbRAVWF2>; Mon, 22 Jan 2001 17:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135460AbRAVWFS>; Mon, 22 Jan 2001 17:05:18 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:12049 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S135304AbRAVWFM>; Mon, 22 Jan 2001 17:05:12 -0500
Message-ID: <3A6CAE8E.CFECDF23@intel.com>
Date: Mon, 22 Jan 2001 14:05:02 -0800
From: "Randy.Dunlap" <randy.dunlap@intel.com>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Duncan Laurie <duncan@virtualwire.org>
CC: Petr Matula <pem@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: int. assignment on SMP + ServerWorks chipset
In-Reply-To: <20010121215423.A20953@virtualwire.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Laurie wrote:
> 
...
> 
> The output you are looking for should look something like this:
> 
> Device 00:0f.0 (slot 0): ISA bridge
>     INTA: link 0x01, irq mask 0x0400 [10]
... 
> Good luck, and feel free to send me the output from "dump_pirq"
> and "mptable" if it doesn't work..

Hi Duncan,

(BTW, it's an STL2 board, not SBT2.  And it's Randy, not Mr. Dunlap. :)

Here's my output from dump_pirq.  Is the PCI router info unique
enough so that you'll need to debug it instead of me doing so?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[root@localhost src]# ./dump_pirq
 
Interrupt routing table found at address 0xfdf10
  Version 1.0, 0 bytes
  Interrupt router is device ff:1f.7
  PCI exclusive interrupt mask: 0x0000 []
 
Interrupt router at ff:1f.7:
Could not read router info from /proc/bus/pci/ff/1f.7.
[root@localhost src]#
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks,
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
