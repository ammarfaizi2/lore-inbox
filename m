Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbTD3VYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTD3VYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:24:23 -0400
Received: from [65.37.126.18] ([65.37.126.18]:12751 "EHLO the-penguin.otak.com")
	by vger.kernel.org with ESMTP id S262442AbTD3VYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:24:22 -0400
Date: Wed, 30 Apr 2003 14:37:07 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Fusion MPT
Message-ID: <20030430213707.GA5406@the-penguin.otak.com>
Mail-Followup-To: Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.5.68 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello I just got in a amazing machine for testing the next couple weeks
But am unable to get it to boot 2.5.x.

The system is a dual xenon system with a Asus pr-dls533 MB, three gigs
of ram and a Fusion MPT scsi subsystem.

2.4.20 boots fine.

Fusion MPT base driver 2.02.01
Copyright (c) 1999-2002 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
mptbase: 2 MPT adapters found, 2 installed.
Fusion MPT SCSI Host driver 2.02.01
scsi0 : ioc0: LSI53C1030, FwRev=01012e00h, Ports=1, MaxQ=255, IRQ=22
scsi1 : ioc1: LSI53C1030, FwRev=01012e00h, Ports=1, MaxQ=255, IRQ=23


2.5.68 and 68-bk9 the driver sees nothing.

I'm still new to the hardware and may be missing somthing, but I doubt
it.

I've made sure to have 

CONFIG_BLK_DEV_SD=y
set, and 
CONFIG_FUSION=y
CONFIG_FUSION_BOOT=y
set, anyone have any ideas?

The system is running current debian sid with the module-init-tools.



-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


