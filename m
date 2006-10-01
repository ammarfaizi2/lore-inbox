Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWJAAKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWJAAKg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 20:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWJAAKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 20:10:36 -0400
Received: from lucidpixels.com ([66.45.37.187]:2286 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751544AbWJAAKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 20:10:36 -0400
Date: Sat, 30 Sep 2006 20:10:34 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
Subject: Linux Kernel 2.6.17.6: pci_set_power_state() question.
Message-ID: <Pine.LNX.4.64.0609302007530.27049@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[5002828.319000] pci_set_power_state(): 0000:01:09.0: state=3, current 
state=5
[5002828.319000] pci_set_power_state(): 0000:01:09.0: state=3, current 
state=5
[5002828.320000] pci_set_power_state(): 0000:01:09.0: state=3, current 
state=5
[5002828.320000] pci_set_power_state(): 0000:01:09.0: state=3, current 
state=5
[5002828.320000] pci_set_power_state(): 0000:01:09.0: state=3, current 
state=5
[5002828.320000] pci_set_power_state(): 0000:01:09.0: state=3, current 
state=5
[5002828.321000] pci_set_power_state(): 0000:01:09.0: state=3, current 
state=5
[5002828.321000] pci_set_power_state(): 0000:01:09.0: state=3, current 
state=5
[5002828.321000] pci_set_power_state(): 0000:01:09.0: state=3, current 
state=5
[5002828.321000] pci_set_power_state(): 0000:01:09.0: state=3, current 
state=5

>From lspci:

01:09.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
         Flags: bus master, medium devsel, latency 248, IRQ 5
         I/O ports at ec60 [size=32]
         Expansion ROM at 30060000 [disabled] [size=64K]

I first started seeing these after upgrading my debian box, not the 
kernel.  Anyone else see these before?

