Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbRBEMoU>; Mon, 5 Feb 2001 07:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129694AbRBEMoK>; Mon, 5 Feb 2001 07:44:10 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:14487 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129352AbRBEMoC>; Mon, 5 Feb 2001 07:44:02 -0500
Message-ID: <3A8141FA.8040202@sympatico.ca>
Date: Wed, 07 Feb 2001 07:39:22 -0500
From: David Pyke <loftwyr@sympatico.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with a Magik1 chipset board
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I own a Iwill KA266 which uses the ALi M1647 northbridge and M1535D+ 
south.  I'm getting errors on startup and thought I should see if this 
is an issue with the set or kernel 2.4.1

First, during the ALI15X3 starup I get:

PCI: No IRQ known for interrupt pin A of device 00:04.0.  Please try 
pci=biosirq

according to /proc/pci,00:04.0 is an ALi M5229 IDE (rev 196).

Second, for agpgart I have to use try_agp_unsupported=1 which gets me

agpgart: Trying generic Ali routines for device id: 1647

according to my nvidia driver proc entry, agp is not enabled.

Is there more information I should provide?

Thanks
Dave Pyke

-- 
No disclaimer shall be read or observed.  Any person (either corporate 
or individual) making any statement shall be held civily and criminally 
liable as a party to any act I may do while following the intentional, 
implied or inferred (whether correctly or not) directions from said 
statement.  So there.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
