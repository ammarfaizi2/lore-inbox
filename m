Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTKDTUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 14:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTKDTUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 14:20:30 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:20243 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S261678AbTKDTU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 14:20:29 -0500
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Some issues with Acer TravelMate 242
Date: Tue, 4 Nov 2003 20:20:26 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311042020.26085.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have Acer TravelMate 242 serie and I have these problems with 2.4 kernel:

1) Compiling into kernel Local APIC causes kernel not booting after reboot - 
Kernel writes Loading kernel and when finished PC freezes. Removing Local 
Apic causes working kernel

problem under 2.6.0-test9 too

2) USB 2.0 - notebook has 4 USB 2.0 ports - modprobe usb-ehci causes loading 
USB and kernel finds USB ports, but when I plug in mouse or BT adapter or 
harddrive into usb ports, those are not recognized anymore.
When I load usb-uhci all works fine, but communication is too slow with my usb 
2.0 harddrive

problem under 2.6.0-test9 too

3) IRDA - there is a new version of existing chip - driver is here and works 
excellent and is backported from 2.6:
http://nemadema.cz/acer/irda.patch
When will be this patch included into 2.4 vanilla?

Thanks for reply

Michal

