Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272882AbTHPNWb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 09:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272890AbTHPNWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 09:22:31 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:55013 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S272882AbTHPNWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 09:22:30 -0400
Message-ID: <0ed701c363f9$47667790$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60> <20030815171636.GA3129@kroah.com>
Subject: Re: Trying to run 2.6.0-test3
Date: Sat, 16 Aug 2003 22:20:55 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Greg KH" <greg@kroah.com> replied to me:

> > 2.  When I attach a USB hard disk drive, 2.6.0 drivers log:
> > [...] no runnable /etc/hotplug/scsi_device.agent is installed
> > 2.4.19 didn't have this problem.  2.4.19 automatically updated
> > /etc/fstab.
>
> Try getting the latest update of the hotplug scripts from
> http://linux-hotplug.sf.net/ if you don't like seeing this in your log
> files.  It's a very harmless message.

Once I know that the message is harmless, I don't need to worry about it.
But it would be nice if 2.6.0 would automatically update /etc/fstab the way
2.4.19 did.  I assume that the new hotplug scripts will do that.

By the way, since we had some discussion of USB keyboards, I want to mention
that it is separate (so far) from the keyboard problems that I've reported
for 2.6.0-test1 through test3.  So far I've only tested 2.6.0 on machines
with PS/2 keyboards (or emulations thereof).  Considering the patch for
test1 which still hasn't made it into test3, maybe I ought to try connecting
a USB keyboard to one machine soon.  Meanwhile I don't dare to even try
2.6.0 on a machine which depends on its USB keyboard (no PS/2 ports and
cessation of BIOS emulation when the OS boots).

