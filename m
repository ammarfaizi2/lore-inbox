Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTLCDXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 22:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTLCDXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 22:23:10 -0500
Received: from web40202.mail.yahoo.com ([66.218.78.63]:47367 "HELO
	web40202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264477AbTLCDXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 22:23:07 -0500
Message-ID: <20031203032307.33575.qmail@web40202.mail.yahoo.com>
Date: Tue, 2 Dec 2003 19:23:07 -0800 (PST)
From: Jim Stark <loontaubag@yahoo.com>
Subject: Problem with USB storage
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I am currently using Slackware 9.1 with a custom built
kernel (2.4.22).  The problem I am having is that
sometimes (not always), I can mount my USB memory
stick.  It happens very infrequently.  When I insert,
the hotplug support detects it and loads usb-storage
and starts two processes (usb-storage-0 and
scsi_eh_1).  Most (99%) of the time, the mount program
freezes when attempting to mount the device, and can
only be stopped by waiting and sending kill -9. 
Thereafter, the device (/dev/sda1) states that it is
not a valid black device AND the USB port I tried to
use becomes unusable until a restart.  Further, the
two processes I described earlier are impossible to
kill.

Any ideas?  I am currently in the process of upgrading
to the newest kernel (2.4.23).  An additional note is
that the ehci-hcd (usb2) module is loaded and I am
trying to use it for the higher transfer rates.

Thanks

Mike

__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
