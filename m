Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAIUqo>; Tue, 9 Jan 2001 15:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAIUqX>; Tue, 9 Jan 2001 15:46:23 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:50958 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S129406AbRAIUqS>;
	Tue, 9 Jan 2001 15:46:18 -0500
Date: Tue, 9 Jan 2001 21:46:14 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101092046.VAA27628@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: usb mouse, iomega zip and 2.2.19-pre7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

usb-mouse
---------
In 2.2.19-pre6 (and previous) we had a CONFIG_INPUT_MOUSEDEV. It has
disapearead in 2.2.19-7. The only alternative for an usb mouse seems 
to be CONFIG_USB_MOUSE which is for an USB HIDBP Mouse.

So there is no mean to get mousedev & input compiled.
Maybe "Input core support" is missing with the matching ../drivers/input 
directory.

Iomega ZIP support
------------------
IOMEGA parallel port (ppa - older drives)
IOMEGA parallel port (imm - newer drives)
Have vanished from the "SCSI low-level drivers" sub-menu.

--------

Regards

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
