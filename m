Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261896AbTCLS5W>; Wed, 12 Mar 2003 13:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbTCLS5W>; Wed, 12 Mar 2003 13:57:22 -0500
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:36232
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S261896AbTCLS5U>; Wed, 12 Mar 2003 13:57:20 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Mar 2003 11:07:34 -0800
MIME-Version: 1.0
Subject: VESA FBconsole driver?
Message-ID: <3E6F14F6.7063.2D30924F@localhost>
In-reply-to: <20030312110748.A9773@devserv.devel.redhat.com>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

A long time ago I remember there was a guy working on a VESA FBconsole 
driver for Linux. Then driver he was working on was structured as a user 
land daemon that the kernel console driver would call back into once the 
system was up, allowing the userland VESA driver to use the vm86() 
service to change modes, program the palette and other useful things that 
can't be done by the basic driver that uses a mode set previously by LILO 
or GRUB.

My first question is, did this project ever get completed and included in 
the Linux kernel at all? Does anyone have any reference to this project 
that you can point me at?

My second question is, is it possible to execute vm86() services from 
*within* the kernel as opposed to from user land? I got the impression at 
the time that the userland daemon was used because vm86() could only be 
called from userland code and could not be called from within the kernel 
to execute real mode VESA BIOS services. Is that correct? If not, can 
vm86() services now be called from other kernel modules inside the 
kernel? 

Feel free to email me directly with information if this is an FAQ to keep 
traffic off the list.

Thanks!

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

