Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265019AbTF2T5h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbTF2T5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:57:37 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:30445 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S264358AbTF2Twh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:52:37 -0400
Subject: [Linux 2.5.73] SCSI Write protect not properly detected
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1056917213.4001.5.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 29 Jun 2003 22:06:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.5.73 the write protect on my SCSI MO drive (via Firewire IDE
enclosure) is not being detected properly. It always says the
write protect is off. The drive itself is properly being detected as
an Optical disk.

<snip>
SCSI device sdf: 605846 2048-byte hdwr sectors (1241 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 56 03 80
sdf: cache data unavailable
sdf: assuming drive cache: write through
 sdf: sdf1
Attached scsi removable disk sdf at scsi2, channel 0, id 0, lun 0

With 2.4 it works properly:

SCSI device sdf: 605846 2048-byte hdwr sectors (1241 MB)
sdf: Write Protect is on
 sdf: sdf1

Cheers,

Jurgen

