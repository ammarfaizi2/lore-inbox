Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbTE2EPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 00:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTE2EPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 00:15:40 -0400
Received: from [203.6.240.4] ([203.6.240.4]:37640 "HELO
	cbus613-server4.colorbus.com.au") by vger.kernel.org with SMTP
	id S261847AbTE2EPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 00:15:39 -0400
Message-ID: <370747DEFD89D2119AFD00C0F017E66126C91D@cbus613-server4.colorbus.com.au>
From: Robert Lowery <Robert.Lowery@colorbus.com.au>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: mounting VXDOS partitions under linux
Date: Thu, 29 May 2003 14:28:51 +1000
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to mount a hard disk out of a VxWorks based embedded system
under linux.

The partitions on the disk apper to be FAT16, except that instead of
restricting the number of sectors per cluster to be a power of 2 (as assumed
by the linux fat module), they can be anything (eg 40 in the partition I am
trying to mount).

Is anyone aware of existing code that can mount these partitions, or should
I get hacking?

-Robert

Robert Lowery
Software Engineer
Colorbus Australia
1044 Dandenong Road, Carnegie, Victoria 3163
E-mail: robert.lowery@colorbus.com.au
Tel direct: +61 3 8574 8033
Fax office: +61 3 8574 8008 

