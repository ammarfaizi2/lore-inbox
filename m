Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130406AbRCIBLq>; Thu, 8 Mar 2001 20:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130407AbRCIBL0>; Thu, 8 Mar 2001 20:11:26 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48400 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130406AbRCIBLN>; Thu, 8 Mar 2001 20:11:13 -0500
Subject: Re: 2.4.2-ac15 -- Build fails in serial.c if CONFIG_SERIAL_CONSOLE is enabled.
To: miles@megapathdsl.net (Miles Lane)
Date: Fri, 9 Mar 2001 01:14:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AA82C12.3000204@megapathdsl.net> from "Miles Lane" at Mar 08, 2001 05:04:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bBTs-00048o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In serial.c, in function `wait_for_xmitr' at lines 5497 and 5666, 
> `ASYNC_NO_FLOW' is undeclared.

Yep. Disable serial console for now. Jeff's serial merge broke serial console
support



