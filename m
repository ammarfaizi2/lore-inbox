Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbUL0NIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbUL0NIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 08:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUL0NIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 08:08:17 -0500
Received: from mail.charite.de ([160.45.207.131]:33506 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261883AbUL0NIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 08:08:14 -0500
Date: Mon, 27 Dec 2004 14:08:13 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: "usbfs: USBDEVFS_BULK failed ep 0x81 len 512 ret -110"
Message-ID: <20041227130813.GB6261@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In both 2.6.10 and 2.6.10-ac1 I get this when I attach my brother-in-law's
Canon IXU II and try to get the photos from the camera using PTP:

usb 1-1: new full speed USB device using uhci_hcd and address 4
usb 1-1: kdeinit timed out on ep1in
usb 1-1: usbfs: USBDEVFS_BULK failed ep 0x81 len 512 ret -110
usb 1-1: kdeinit timed out on ep1in
usb 1-1: usbfs: USBDEVFS_BULK failed ep 0x81 len 512 ret -110
usb 1-1: kdeinit timed out on ep1in
usb 1-1: usbfs: USBDEVFS_BULK failed ep 0x81 len 512 ret -110
usb 1-1: kdeinit timed out on ep1in

It DOES work - eventually - but it's incredibly slow, since konqueror /
kdeinit runs into a timeout on each operation.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
