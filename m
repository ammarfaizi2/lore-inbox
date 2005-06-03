Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVFCR1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVFCR1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 13:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVFCR1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 13:27:25 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:55216
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S261412AbVFCR1C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 13:27:02 -0400
Message-ID: <20050603172701.29736.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: linux-kernel@vger.kernel.org
cc: dag@newtech.fi
Subject: OHCI driver have problems with USB 2.0 memory devices
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 03 Jun 2005 20:27:01 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

just installed 2.6.11.11 on a single board computer using
a SGS Thomson integrated USB controller and found that
inserting a USB 2.0 stick generated a "IRQ INTR_SF lossage"
message and further lockup of the driver. Ie. a cat of 
/proc/bus/usb/devices will freeze the cat process.

Using a USB 1.1 stick works fine.

At the moment I don't have any logs to send you as the device
is not connected to anything.

One thing to consider is that the 2.0 stick was formatted without
a partition table and the 1.1 had partitions.

I don't mind being unable to use the 2.0 stick, but the freezing of the
driver shouldn't happen. Now a reboot is needed after a 2.0 stick has
been inserted to clear the situation.

Please tell me what logs you need and I will try to provide them to you.

Best from Finland
Dag

