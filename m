Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbUBVJlN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 04:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUBVJlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 04:41:13 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:12554 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261209AbUBVJlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 04:41:08 -0500
Date: Sun, 22 Feb 2004 10:41:06 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Manish Lachwani <lachwani@pmc-sierra.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: i2c-yosemite
Message-Id: <20040222104106.714de992.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

I saw that there is a new driver named i2c-yosemite in Linux 2.6.3-mm2.
Quoting your words in the header:

"Currently, this Linux driver wont be integrated into the generic Linux
I2C framework."

Why that?

If everyone reimplements what already exists, the kernel is likely to go
bigger with no benefit. Also, you won't be able to use all user-space
tools that already exist, and will also have to write specific chip
drivers for the chips present on the yosemite bus, although these
drivers (Atmel 24C32 EEPROM and MAX 1619) already exist.

Please explain to us why you cannot/don't want to use the existing i2c
subsystem.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
