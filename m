Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUGMCZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUGMCZz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 22:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUGMCZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 22:25:55 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:22657 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S261451AbUGMCZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 22:25:53 -0400
Date: Tue, 13 Jul 2004 04:25:51 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
Subject: SATA disk device naming ?
Message-ID: <Pine.LNX.4.44.0407130415430.15806-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

After a rather tiresome nightly sit through, we discovered that when
going from kernel 2.6.3 to kernel 2.6.7 the SATA disk device naming
on at least the AMD64 platform changes from : /dev/hde and up 
to /dev/sda and up. What a total disaster. 

Effectively this means that your installed AMD64 platform based
linux distro cannot mount its root filesystem anymore.

We installed mandrake 10.0 amd64 and had to go back todo a initial
install on a UDMA IDE disk on /dev/hda.

Is there in such cases a smart workaround available, maybe as an extra
GRUB/LILO boot option ? And why was the device naming changed in 
such a fatal way, effectively going from IDE to SCSI device names.

Googling for "kernel init no init found" results in :

Results 11 - 20 of about 323,000 for kernel init no init found. 
ouch :(

Regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

