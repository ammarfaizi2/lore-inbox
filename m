Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUGOTZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUGOTZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 15:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUGOTZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 15:25:57 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:22694 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S266291AbUGOTZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 15:25:55 -0400
Message-ID: <40F693EE.5D65D02F@verizon.net>
Date: Thu, 15 Jul 2004 20:25:50 +0100
From: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI configuration changes getting lost.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [4.15.37.40] at Thu, 15 Jul 2004 14:25:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble with an old Thinkpad 760 ED.

The BIOS puts junk (0xFF) in the INTERRUPT_LINE register of the PCMCIA
configuration registers.  I can put the correct value (0x05) in with
'setpci', but the information is not propagated to the /proc space.
The information is not preserved after an 'init 6'.

(There is at least one other BIOS induced problem with this machine
and PCI configuration registers but it is a bit less serious.  I do 
have the latest BIOS.)

What would be involved in updating the /proc information when 'setpci'
is used to change the configuration?

Does the other pci 'fixer' 'pcitweak' do a better job?

[Don't remove PCI from the subject line.  I'm using it to keep track
of interesting things in this otherwise very noisy mailing list.]

max@mtew.isa-geek.net
