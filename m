Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTKTOeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 09:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTKTOeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 09:34:02 -0500
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:55999 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261879AbTKTOd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 09:33:58 -0500
From: Frank Dekervel <kervel@drie.kotnet.org>
To: linux-kernel@vger.kernel.org
Subject: ttyUSB (pocketpc - IPAQ) non-functional in 2.6 kernels
Date: Thu, 20 Nov 2003 15:33:55 +0100
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200311201533.56180.kervel@drie.kotnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

since i switched to kernel 2.6 (test8, test9, test9-mm4) i'm unable to connect 
(ppp over ttyUSB) to an ipaq. In 2.4 everything works fine, the connection 
times out.

--------------- dmesg output
hub 2-0:1.0: new USB device on port 1, assigned address 4
usbserial 2-1:1.0: PocketPC PDA converter detected
usb 2-1: PocketPC PDA converter now attached to ttyUSB0 (or usb/tts/0 for 
devfs)
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
usb 2-1: USB disconnect, address 4
usbserial 2-1:1.0: device disconnected
hub 2-0:1.0: new USB device on port 1, assigned address 5
usbserial 2-1:1.0: PocketPC PDA converter detected
usb 2-1: PocketPC PDA converter now attached to ttyUSB1 (or usb/tts/1 for 
devfs)

greetings,
frank





-- 
Frank Dekervel - frank.dekervel@student.kuleuven.ac.be
Mechelsestraat 88
3000 Leuven (Belgium)
