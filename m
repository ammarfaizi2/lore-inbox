Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWFTQLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWFTQLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWFTQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:11:19 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:26583 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S1751295AbWFTQLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:11:18 -0400
Date: Tue, 20 Jun 2006 18:11:08 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
cc: Kay Sievers <kay.sievers@vrfy.org>, Hannes Reinecke <hare@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@redhat.com>
Subject: udev bluez
Message-ID: <Pine.LNX.4.44.0606201759140.11776-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.3 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems the story of the greatest piece of software ever written
is being hit by the bluez of having to support too many seperate
addon hardware devices, which the coders themselves in many cases
never heard of. Until the udev problems showup.

The key piece of trouble is udev which has nowadays has to run
in close cooperation with a daemon called hald. I wonder if linux is
trying to solve the problems of 'broken by design' addon hardware?
To me it just looks like polishing up a can of maggots.

The most evil category seem to be USB camara's , photo devices, etc.

"I've even created a standalone udev rule - 
  BUS="usb", SYSFS{idVendor}=="04a9", SYSFS{idProduct}=="3113",
  MODE="0660", GROUP="camera", NAME="canon", SYMLINK="camera

"aah canon ... with a canon you can't!"

So is there a smart way out of this mess?

Regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

