Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTEEVZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTEEVZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:25:26 -0400
Received: from pointblue.com.pl ([62.89.73.6]:9999 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261365AbTEEVZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:25:24 -0400
Subject: [COMPILATION ERROR] 2.5.69 drivers/bluetooth/hci_usb.c
	USB_ZERO_PACKET
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1052170326.11699.2.camel@nalesnik>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 May 2003 22:32:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/bluetooth/hci_usb.c : 
USB_ZERO_PACKET definition is missing if CONFIG_BT_SUB_ZERO_PACKET is
not defined.

#define USB_ZERO_PACKET 0

in this file helps, but i guess it is not the best and fully correct
solution :)

Cheers!

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

