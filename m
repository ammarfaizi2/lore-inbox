Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267171AbUHDBIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267171AbUHDBIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267176AbUHDBIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:08:10 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:12223 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267171AbUHDBIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:08:07 -0400
Subject: HCI USB on USB 2.0: hci_usb_intr_rx_submit (works with USB 1.1)
From: "Raf D'Halleweyn (list)" <list@noduck.net>
To: marcel@holtmann.org, maxk@qualcomm.com,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 03 Aug 2004 20:59:53 -0400
Message-Id: <1091581193.15561.3.camel@alto.dhalleweyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems that hci_usb does not like USB 2.0: when I connect a D-Link USB
bluetooth dongle (DBT-120) to a USB 2.0 port, I get the following error
message when I try to 'hciconfig hci0 up':

hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f768ae94 err -28

If I connect the same dongle through a USB 1.1 hub on the same USB 2.0
port, the device comes up and I don't get this error.

Regards,

Raf.

