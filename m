Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265132AbUFVVml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbUFVVml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUFVVki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:40:38 -0400
Received: from ipx10069.ipxserver.de ([80.190.240.67]:38331 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S266006AbUFVVim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:38:42 -0400
Date: Tue, 22 Jun 2004 23:38:30 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: ieee1394: unsolicited response packet received - no tlabel match
Message-ID: <20040622213830.GA11770@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an excerpt from my dmesg.  I am using a large Maxtor firewire
hard disk as VCR storage.  This happens only when I read large files
from the external firewire disk, not when watching an AVI movie on it
(i.e. reading it slowly).

Jun 22 22:58:43 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 22:58:43 hellhound 0x28 00 02 3c 93 a5 00 00 01 00 
Jun 22 22:58:43 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 22:58:43 hellhound 0x28 00 02 3c 93 a6 00 00 01 00 
Jun 22 22:58:43 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 22:58:43 hellhound 0x28 00 02 3c 93 a7 00 00 01 00 
Jun 22 22:58:43 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 22:58:43 hellhound 0x28 00 02 3c 93 a8 00 00 01 00 
Jun 22 22:58:43 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 22:58:43 hellhound 0x28 00 02 3c 93 a9 00 00 01 00 
Jun 22 22:58:43 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 22:58:43 hellhound 0x28 00 02 3c 93 aa 00 00 01 00 
Jun 22 22:58:43 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 22:58:43 hellhound 0x28 00 02 3c 93 ab 00 00 01 00 
Jun 22 22:58:43 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 22:58:43 hellhound 0x28 00 02 3c 93 ac 00 00 01 00 
Jun 22 23:25:40 hellhound ieee1394: unsolicited response packet received - no tlabel match
Jun 22 23:26:44 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:26:44 hellhound 0x28 00 13 82 4b 76 00 00 80 00 
Jun 22 23:26:44 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:26:44 hellhound 0x28 00 13 82 4b f6 00 00 01 00 
Jun 22 23:26:44 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:26:44 hellhound 0x28 00 13 82 4b f7 00 00 01 00 
Jun 22 23:26:44 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:26:44 hellhound 0x28 00 13 82 4b f8 00 00 01 00 
Jun 22 23:26:44 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:26:44 hellhound 0x28 00 13 82 4b f9 00 00 01 00 
Jun 22 23:26:44 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:26:44 hellhound 0x28 00 13 82 4b fa 00 00 01 00 
Jun 22 23:26:44 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:26:44 hellhound 0x28 00 13 82 4b fb 00 00 01 00 
Jun 22 23:26:44 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:26:44 hellhound 0x28 00 13 82 4b fc 00 00 01 00 
Jun 22 23:29:34 hellhound ieee1394: unsolicited response packet received - no tlabel match
Jun 22 23:33:06 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:33:06 hellhound 0x28 00 1c b3 fe ed 00 00 80 00 
Jun 22 23:33:06 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:33:06 hellhound 0x28 00 1c b3 ff 6d 00 00 01 00 
Jun 22 23:33:06 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:33:06 hellhound 0x28 00 1c b3 ff 6e 00 00 01 00 
Jun 22 23:33:06 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:33:06 hellhound 0x28 00 1c b3 ff 6f 00 00 01 00 
Jun 22 23:33:06 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:33:06 hellhound 0x28 00 1c b3 ff 70 00 00 01 00 
Jun 22 23:33:06 hellhound ieee1394: sbp2: aborting sbp2 command
Jun 22 23:33:06 hellhound 0x28 00 1c b3 ff 71 00 00 01 00 

[and so on]

After 20-30 seconds, everything gets back to normal.  The copied files
appear intact despite these timeouts.  Known problem?  Is my hardware
getting bad?

Felix
