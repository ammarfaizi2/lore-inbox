Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTEUMlc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 08:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTEUMlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 08:41:32 -0400
Received: from [65.244.37.61] ([65.244.37.61]:43225 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S262013AbTEUMlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 08:41:31 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A920217E8C8@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: "Feldman, Scott" <scott.feldman@intel.com>, linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com, akpm@digeo.com, davej@suse.de,
       Linux NICS <linuxnics@mailbox.cps.intel.com>
Subject: RE: [Patch] e100 driver patch for 2.5 - option to restore old beh
	avior
Date: Wed, 21 May 2003 08:53:38 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Feldman, Scott [mailto:scott.feldman@intel.com]
Sent: Tuesday, May 20, 2003 5:01 PM

>> These patches add a module parameter to restore older
>> EEPROM behavior to the Intel e100 NIC driver.
>
> We want the check to fail to detect mis-programmed eeproms.  The
> checksum test isn't conclusive, but it does provide an indication
> something is wrong.

I agree that the default behavior should be that the driver fails.
But in some cases it might be desirable to continue.  (This was
the behavior of both the original and the Becker drivers.)  My
patch just offers the sysadmin or developer or whatever the option
to continue on EEPROM error.
