Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUFOEmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUFOEmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 00:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUFOEmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 00:42:19 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:56540 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S265002AbUFOEmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 00:42:17 -0400
Message-ID: <40CE7E28.4090707@sympatico.ca>
Date: Tue, 15 Jun 2004 00:42:16 -0400
From: Chris Friesen <chris_friesen@sympatico.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net,
       linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net
Subject: [BUG]  problem with usb-storage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running an x86 version of 2.6.5, attempting to use a lexar CF memory
card with the Jumpshot card reader.

possibly relevent config options:

CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_CHR_DEV_SG=y
CONFIG_USB=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_JUMPSHOT=y


When I plug the card in I get the following:

Jun 14 23:27:42 doug kernel: usb 2-2.1: new full speed USB device using
address 4
Jun 14 23:27:42 doug kernel: usb-storage: probe of 2-2.1:1.0 failed with
error -5

It works fine under windows.

Chris

