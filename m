Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTKELcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 06:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTKELcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 06:32:09 -0500
Received: from linux-bt.org ([217.160.111.169]:23694 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262834AbTKELcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 06:32:06 -0500
Subject: Re: test9 and bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200311021853.47300.cova@ferrara.linux.it>
References: <200311021853.47300.cova@ferrara.linux.it>
Content-Type: text/plain
Message-Id: <1068031899.10388.180.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 05 Nov 2003 12:31:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

> Bluetooth USB crashses
> 
> I'm playing with a Bluetooth USB dongle (D-LINK DBT 120) and it works quite 
> well,  but when I unplug the dongle the system freeezes immediately. I've 
> tried to unplug other USB devices as scanner or printer but without crashes.
> 
> System: PIV 2.8 Abit IC7-G MB;
> 2.6.0-test9 #3 SMP
> Relevant Modules:
> bnep
> l2cap
> bluetooth
> uhci_hcd
> ehci_hcd
> hci_usb
> rfcomm
> 
> I'm not using devfs but udev/sysfs.
> 
> I get no informations/messages in logs.
> I'm using the same dogle and usb devices on a 2.4.21 kernel (on a different 
> HW) and I can remove the dongle without any problem.
> 
> If more informations or tries are needed just let me know.

please try this with a non SMP kernel and/or a non preempt kernel. Do
you have enabled the Bluetooth SCO support for the HCI USB driver?

Regards

Marcel


