Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVDFGWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVDFGWt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 02:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVDFGWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 02:22:49 -0400
Received: from main.gmane.org ([80.91.229.2]:6327 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262118AbVDFGWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 02:22:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "shaun" <mailinglists@unix-scripts.com>
Subject: kernel panic - not syncing: Fatal exception in interupt
Date: Tue, 5 Apr 2005 23:04:11 -0700
Message-ID: <d2vu0u$oog$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-111-70-41.oc.oc.cox.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2741.2600
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2742.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+Hardware Specs
Dual Xeon 800FSB
Intel Server Board
4GB ECC DDR
3ware 9500 Sata Raid Card
5x200 GB sata drives in a raid 10 Config (1 hot spare)
Dual Nic

+OS Specs
CentOS 3.4 running a custom 2.6.x kernel patched with UML SKA's Patch
eth0 is 0.0.0.0 promisc and assigned to a bridge (br0)
tuntap devices up
ebtables is enabled and loaded with rules

My problem is that every other week or so the machine crashes.  It never
dumps the error to the logs so all i have is a screen shot of the console.
I have put some serious stress on this machine and have been unable to
duplicate the problem (running 20 guest UML's half running va-ctcs and the
other half compiling a 2.6 kernel).   Below is a link to 2 screen shots i
have (about 2 weeks apart).  I started off using a 2.6.10 kernel when the
problem started.  Last time the machine crashed i built a 2.6.11.5 kernel
and disabled APM and ACPI in the kernel config.  Any body know whats going
on here.

http://www.unix-scripts.com/shaun/host-screenshot-1.png
http://www.unix-scripts.com/shaun/host-screenshot-2.png

Kernel Config... http://www.unix-scripts.com/shaun/2.6.11.5-hr1_.config

--
Best Regards,

Shaun Reitan




