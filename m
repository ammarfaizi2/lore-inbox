Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbTHTCXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 22:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbTHTCXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 22:23:06 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:3712
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261512AbTHTCXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 22:23:03 -0400
Date: Tue, 19 Aug 2003 22:20:51 -0500 (CDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: greg@kroah.com, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Console on USB
Message-ID: <Pine.LNX.4.44.0308192200510.886-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just spent a very frustrating evening trying to get console on USB 
working.  My laptop does not have regular DB-9 serial connectors, only 
USB.  So I ordered a USB to serial converter, configured a 2.6.0-test3 
kernel, added a console=/dev/ttyUSB0 to the kernel command line and 
connected this to my desktop with a null modem adapter.  However, I am 
unable to get output from this setup on the desktop.  On another setup I 
can get a normal serial console output, so I am fairly confident I can set 
things up correctly.

Googling around and doing a search on lkml archives gave some minimal 
help, but I can find very little info past early to mid 2.5 kernels.  The 
configuration doesn't quite seem to work the way I read documentation.  
For instance, the web pages I can find indicate I should be able to build 
this modular; however the configuration makes the setting of console on 
usb depend on USB being y and EXPERIMENTAL being defined.  

In /var/log/messages I can see the USB-to-serial converter being recogized 
and the driver being loaded, just before the synaptics touchpad is probed.

It looks like things are correct, but, as I said, I am unable to get 
output.  Am I headed for frustration, or is there some advice to get good 
results?  

Is there any advice I might be able to use to get this going?  I really 
want to be able to catch some oops output.

