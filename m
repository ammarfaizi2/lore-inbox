Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTGFLBh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 07:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTGFLBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 07:01:37 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:58085 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S261874AbTGFLBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 07:01:36 -0400
Date: Sun, 6 Jul 2003 13:16:05 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: usb-storage doesn't recognize a Sony DSC-P92
Message-ID: <20030706111605.GA12809@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030705212021.GB21621@charite.de> <20030706055347.GA3291@kroah.com> <20030706075334.GB30442@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706075334.GB30442@charite.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:

> > What kernel are you using?
> 
> 2.4.21-ac4
> 
> > If it doesn't work in the latest 2.4.22-pre3 kernel, please let us know.
> 
> I'll try that.

With 2.4.22-pre3 it works flawlessly. Well, almost. I can attach the
camera, mount the camera as /dev/sda1 and read the data. Neat!

Upon umount, I got a message saying "host controller halted. very bad".

>From the kern.log:

Jul  6 13:09:53 hummus kernel: usb-storage: storage_disconnect() called
Jul  6 13:09:53 hummus kernel: usb-storage: -- releasing main URB
Jul  6 13:09:53 hummus kernel: usb-storage: -- usb_unlink_urb() returned -19
Jul  6 13:09:53 hummus kernel: usb.c: kusbd: /sbin/hotplug remove 2
Jul  6 13:09:53 hummus kernel: hub.c: port 2, portstatus 100, change 0, 12 Mb/s
Jul  6 13:09:54 hummus kernel: uhci.c: root-hub INT complete: port1: 88 port2: 80 data: 2
Jul  6 13:09:54 hummus kernel: uhci.c: ffe0: suspend_hc
Jul  6 13:09:54 hummus kernel: uhci.c: ffe0: host controller halted. very bad
Jul  6 13:09:54 hummus kernel: uhci.c: ffe0: wakeup_hc
Jul  6 13:09:54 hummus kernel: hub.c: port 1, portstatus 100, change 2, 12 Mb/s
Jul  6 13:09:54 hummus kernel: hub.c: port 1 enable change, status 100
Jul  6 13:09:54 hummus kernel: hub.c: port 2, portstatus 100, change 0, 12 Mb/s

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
