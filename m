Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbTCVN04>; Sat, 22 Mar 2003 08:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262751AbTCVN04>; Sat, 22 Mar 2003 08:26:56 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:26417 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S262750AbTCVN0y>; Sat, 22 Mar 2003 08:26:54 -0500
From: Jos Hulzink <josh@stack.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.65: IRQ remapping problems
Date: Sat, 22 Mar 2003 14:37:52 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303221437.52499.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now 2.5.65 boots again, I'm able to confirm that the SCSI (AIC7880) issues I 
have are caused by (disfunctional) IRQ remapping code. A BIOS without MPS 1.4 
support enabled (which causes interrupt remapping on this P2L97-DS, Intel 440 
LX mainboard) makes the SCSI driver run fine.

I expected the 3Com 3c905 problems (no communication) to be fixed too, though 
they still occur. Now updating modutils so I can do tests without rebooting.

Jos 
