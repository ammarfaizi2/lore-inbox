Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270380AbTGMUjN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270383AbTGMUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:39:13 -0400
Received: from web13305.mail.yahoo.com ([216.136.175.41]:62485 "HELO
	web13305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270380AbTGMUi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:38:59 -0400
Message-ID: <20030713205345.94472.qmail@web13305.mail.yahoo.com>
Date: Sun, 13 Jul 2003 13:53:45 -0700 (PDT)
From: Ronald Jerome <imun1ty@yahoo.com>
Subject: Rusty's mod-util and RH9.0 Question Please?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I updated my modutils with rusty's modutils
"module-init-tools-0.9.13-pre"

With the aid of paul Nasrat, he prepared me more
updated modutils and mkinitrd to make both a 2.4 and
2.5 boot correctly.

I am not sure what happend but it looks like my
"modprobe" disapeared?

Luckily before I ran the new modutils for 2.5 I copied
all my modutils as *.org.  insmod, depmod, modprobe,
rmmod, lsmod all to *.old.

Only problems is 2.5 kernels do not want that
/sbin/modprobe which I renamed from modprobe.org to 
modprobe in order to get the 2.4 kernel to insmod
correctly again.  

My question is, after updating the modutils is there a
/sbin/modprobe or is it renamed by the modutils upadte
to /sbin/modprobe.old and if that is the case why
isn't the 2.4 kernels using that?  It all of a sudden
is looking for /sbin/modprobe.

I had to cp the modprobe.org file that I saved to
modprobe and now the 2.4 kernels work fine again but
2.5 kernels do not work right with /sbin/modprobe.  SO
Now I have to manually remove /sbin/modprobe to boot
up 2.5 kernels and put modprobe back to boot up 2.4
kernels.

WHat can I do to fix this.  Is maybe asymlink borken? 
do I need to symlinke the modprobe.old which it is
already symlinked to insmode.old.

DO I have to modify my script in /etc/rc.d/rc.sysinit?


If I leave the modprobe file in /etc/modprobe then the
modules for 2.5 kernels do not load correctly.

I get these messages"

GM _MODULES function not implemented 
for ieee1394 and for usb.

Just those two fail during the INIT: phase of the
kernel 2.5 bootup.


Can someone help me or explain to me what I need to
do?

SHoudl I reinstall rusty's modutils?  If so what how
do I about that?  Maybe I shoudl reinstall the
oldpackage that came with RH v9.0 then reinstall the
rusty over again?

Anyideas would be helpfull at this point.

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
