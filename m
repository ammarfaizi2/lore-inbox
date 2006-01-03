Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWACSFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWACSFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWACSFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:05:37 -0500
Received: from mail1.rx30.com ([63.168.173.10]:50626 "EHLO hermes.rx30.com")
	by vger.kernel.org with ESMTP id S932350AbWACSFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:05:36 -0500
Subject: Boot hang on 2.6.14
From: Peter Lauda <plauda@rx30.com>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 03 Jan 2006 13:13:04 -0500
Message-Id: <1136311996.10020.21.camel@plauda5.rx30.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been looking all day for any FAQ or answer to this question/problem
and finally have to post here because I am out of options.

I have setup a system (Dell Precision 380 w/sata HD's on separate
channels) in a RAID1 software config. I added the SATA/SCSI/RAID drivers
to the kernel. I want to boot from /dev/md1 as the root FS /dev/md0 as
boot. 

When the system is coming up, I see it load the md parts and then the
SCSI (I think sg) parts. Then it seems to be loading the next
module/driver as a mouse driver but after echoing the line to the
console, the system hangs indefinitely with no further messages or
output.

I did this easily in 2.5.29 by creating a custom initrd that loaded all
the modules, crafted the arrays, and then let the system use it for root
mount.

I'm confident I'm close to getting this going since I've been beating on
it a while now but without any other message to go on, I don't know what
to look for next.

Can anyone here give me some tips on how to enable boot time debugging
or any other tricks/tips that may shed light on where things are
failing?

Any input greatly appreciated.

--p

