Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSLLOHa>; Thu, 12 Dec 2002 09:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbSLLOH3>; Thu, 12 Dec 2002 09:07:29 -0500
Received: from [217.222.53.238] ([217.222.53.238]:22278 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id <S264818AbSLLOH2>;
	Thu, 12 Dec 2002 09:07:28 -0500
Message-ID: <3DF899E8.2050903@gts.it>
Date: Thu, 12 Dec 2002 15:15:04 +0100
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: "Grover, Andrew" <andrew.grover@intel.com>
Subject: [ACPI] [2.5.51] Error on reading BAT1/state
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an HP Omnibook XE3L notebook, running kernel 2.5.51: everything
looks fine except for this messages when doing a cat on
/proc/acpi/battery/BAT1/state (note that alarm and info have no
problem):

  exfldio-0122 [28] Ex_setup_region       : Field [ACPW]
Base+Offset+Width 38+0+4 is beyond end of region [GPIO] (length 3B)
   psparse-1103: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.BAT1._BST] (Node c76755c8), AE_AML_REGION_LIMIT
   acpi_battery-0206 [12] acpi_battery_get_statu: Error evaluating _BST
   present:                 yes
   ERROR: Unable to read battery status
    exfldio-0122 [28] Ex_setup_region       : Field [ACPW]
Base+Offset+Width 38+0+4 is beyond end of region [GPIO] (length 3B)
     psparse-1103: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.BAT1._BST] (Node c76755c8), AE_AML_REGION_LIMIT
     acpi_battery-0206 [12] acpi_battery_get_statu: Error evaluating _BST

(This is with ACPI debug kernel option)

Bye

-- 
Stefano RIVOIR


