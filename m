Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVFHRbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVFHRbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVFHRbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:31:08 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:38930 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261406AbVFHR1q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:27:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VW+wcwAuksIN3aDi/WKg+B5cT5HE4OTon5tblsne/t037pE906iLDjyS6M4U/h9I83CJiPtqzX3pUNXhBkPjF+Ih6NrthqSlyoPWyv5h/RoZiXHC6ECsNBtQWEFfJtQWncpivE1zkj+5J5AqkpKs1qBSTmZ1FClXzCRP9GsdjLw=
Message-ID: <c775eb9b0506081027d0cc6b9@mail.gmail.com>
Date: Wed, 8 Jun 2005 13:27:42 -0400
From: Bharath Ramesh <krosswindz@gmail.com>
Reply-To: Bharath Ramesh <krosswindz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: USB errors causes system to become unresponsive
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running the 2.6 kernel and I notice that every now and then my
system stops responding but is still accessible remotely through ssh.
I can not work on the console. The only way out is to reboot either
remotely or by hitting the reset button. When the system comes up
again I get the following message in my dmesg and I need to actually
reboot it once or twice before this error goes. of I get a spew of
following messages. These messages don't stop till I reboot the
machine.

drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
drivers/usb/input/hid-core.c: input irq status -75 received
