Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVLGPob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVLGPob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVLGPoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:44:30 -0500
Received: from bay103-f16.bay103.hotmail.com ([65.54.174.26]:11207 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751151AbVLGPoa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:44:30 -0500
Message-ID: <BAY103-F1629FE16D5F4DBB7B16524DF430@phx.gbl>
X-Originating-IP: [68.252.185.41]
X-Originating-Email: [dravet@hotmail.com]
From: "Jason Dravet" <dravet@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: wrong number of serial port detected
Date: Wed, 07 Dec 2005 09:44:29 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Dec 2005 15:44:29.0870 (UTC) FILETIME=[1C756CE0:01C5FB45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a question about the way serial ports are detected.  Since I started 
using udev last year I noticed 32 ttySxx nodes in my /dev directory.  I 
checked dmesg and the serial port driver was detecting 32 ports.  Here is 
the line from dmesg:
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
In fact I don't have 32 ports.  I have two serial ports on the motherboard, 
both of which are disabled in the BIOS.  I opened a bug in RedHat's bugzilla 
system and it was promptly closed saying this was unfixable.  I was told 
that the kernel loaded the maximum number of ports supported by the serial 
port driver.  I asked why and I have not received a response.  So I ask this 
mailing list Can the kernel detect the proper number of serial ports or not?

Thanks,
Jason


