Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270620AbTGUQvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270623AbTGUQvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:51:54 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:28369 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S270620AbTGUQv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:51:26 -0400
Message-Id: <5.1.0.14.2.20030721100313.0759df08@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 21 Jul 2003 10:06:19 -0700
To: Florian Lohoff <flo@rfc822.org>, linux-kernel@vger.kernel.org
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [2.4.21] bluez/usb-ohci bulk_msg timeout
In-Reply-To: <20030718173214.GD15430@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:32 AM 7/18/2003, Florian Lohoff wrote:

>Hi,
>since 2.4.21 + mh2 bluez patch i am seeing these errors. 2.4.20 + mh7
>bluez patch did not show these errors. Results are very instable
>Bluetooth connections.
Those errors don't seem to be related to the driver update. But you could
try this. In drivers/bluetooth/hci_usb.h set HCI_MAX_BULK_TX define to 1 (instead of 4)
and rebuild the module. Does it make any difference ?

Max
        

