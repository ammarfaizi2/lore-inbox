Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUHUNxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUHUNxA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 09:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUHUNxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 09:53:00 -0400
Received: from web41704.mail.yahoo.com ([66.218.93.121]:34491 "HELO
	web41704.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266048AbUHUNwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 09:52:51 -0400
Message-ID: <20040821135250.41480.qmail@web41704.mail.yahoo.com>
Date: Sat, 21 Aug 2004 06:52:50 -0700 (PDT)
From: "Joseph M. Hinkle" <dunsalen@yahoo.com>
Subject: menuconfig information deficiencies
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few places in menuconfig where no
information is given and should be.  If something is
compiled as a module, the module name should at least
be listed.  A short reason for including the item
should be given, and a long one is better.  Simply
"You need this" or "If in doubt say Y" is
insufficient.

In kernel 2.6.8: (If information isn't present here,
it probably never has been in any kernel)


ATA/ATAPI/MFM/RLL Support
   IDE Taskfile IO
      "It is safe to say Y to this question in most
cases"
Oh? And what might the cases be where it is not?  What
are typical indications this might cause trouble?

ATA/ATAPI/MFM/RLL Support
   generic/default IDE chipset support
      "If unsure say Y"
Is this essential if one knows the IDE chipset as
obtained from lspci?  What is the module name if
compiled as a module?

ATA/ATAPI/MFM/RLL Support
   Generic PCI IDE Chipset Support
      "There is no help for this option"
Why is that?  Must it never be used?  Why is it
selected by default? Does it need to be selected if
the IDE chipset is known? 

ATA/ATAPI/MFM/RLL Support
   PROMISE PDC202{68|69|70|71|75|76|77} support
      "There is no help available for this kernel
option"
None of the other specific chipset items fail to
mention the module name either.  At least the others
make some attempt to keep the configurer informed of
basic issues.

SCSI device support
   SCSI Transport Attributes
      Parallel SCSI (SPI) Transport Attributes
No mention of the module name is made.
      FiberChannel Transport Attributes
No mention of the module name is made.

   SCSI low-level drivers
      3ware 5/6/78xxx ATA-RAID support
      3ware 9xxx SATA-RAID support
No mention of the module name is made.





		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
