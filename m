Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311664AbSCNQkr>; Thu, 14 Mar 2002 11:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311665AbSCNQkh>; Thu, 14 Mar 2002 11:40:37 -0500
Received: from mailx.danfoss.com ([193.162.34.6]:40715 "EHLO
	df01-e12.danfoss.dk") by vger.kernel.org with ESMTP
	id <S311664AbSCNQka> convert rfc822-to-8bit; Thu, 14 Mar 2002 11:40:30 -0500
Message-ID: <829F632D2F25D411B6920008C716F831039FB26C@dd01-e01.drives.danfoss.dk>
From: Hansen Martin <DKDD0MAR@Danfoss.com>
To: linux-kernel@vger.kernel.org
Subject: Accessing serial device from within
Date: Thu, 14 Mar 2002 17:40:12 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writing a module, that will communicate with a device attached to the
serial port.

 How can I do that from inside a module, using the present uart driver?
I want to do something like finding and calling the read/write routine that
is called by the kernel when a process from user space accesses the
/dev/ttyS1.

The reason I want to do it this way is that I don't want my module to only
fit one uart.

-- 
Martin Hansen
Student at SDU Sønderborg. www.sdu.dk
Writing final project at Danfoss drives. www.danfossdrives.com

Tlf: 74 88 54 62
