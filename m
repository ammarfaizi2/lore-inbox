Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbUBEKMi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUBEKMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:12:38 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:44469 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264558AbUBEKMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:12:37 -0500
Subject: ATAPI device errors
From: Patrick Dohman <pdohman@comcast.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 05 Feb 2004 04:16:24 -0600
Message-Id: <1075976185.1369.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My CDROM & CDRW are problematic. I am running a 2.4.24 kernel. I suspect
a hardware problem but I am unsure if the problem lies with the CDROM,
CDRW or the IDE/ATAPI controler. Basically the the issue boils down to
having one or both of the drives fall offline after a day or two of
uptime. My logs are spammed with this.

:hdd: packet command error: status=0x51 { DriveReady SeekComplete Error}
:hdd: packet command error: error=0x40
:ATAPI device hdd:
:Error: Hardware error -- (Sense key=0x04)
:(vendor-specific error) -- (asc=0x90, ascq=0x00)
:The failed "Test Unit Ready" packet command was: 
:"00 00 00 00 00 00 00 00 00 00 00 00 "

Is there a more verbose form of logging I can enable. Any clarification
is very much appreciated. 
Thank you




