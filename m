Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTFZT5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 15:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTFZT5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 15:57:19 -0400
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:48865 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S263638AbTFZT5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 15:57:14 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D551DF@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: tony.luck@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.72 doesn't boot solution
Date: Thu, 26 Jun 2003 14:11:24 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

I have compared the working configuration file and original one, and do see some possible setting issues.  I am tied up by other stuff and don't have time to confirm it now.  The suspicious parts are:

CONFIG_BLK_DEV_INITRD
CONFIG_SERIAL_8250
CONFIG_VGA_CONSOLE
CONFIG_SERIAL_CORE
CONFIG_SERIAL_CORE_CONSOLE

All above are set to yes in working configuration file but no in original file.

Eddie


> -----Original Message-----
> From: Luck, Tony [mailto:tony.luck@intel.com]
> Sent: Wednesday, June 25, 2003 4:12 PM
> To: yiding_wang@agilent.com
> Subject: RE: 2.5.72 doesn't boot
> 
> 
> Great!  Did can you compare the non-working and working
> .config files to see what it causing this?  If you find
> something post to the kernel mailing list, I'm sure it
> will be of general interest (since at least two of us hit
> this problem).
> 
> -Tony
 
