Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbTJJHyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 03:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTJJHyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 03:54:37 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:61893 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S262474AbTJJHyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 03:54:35 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: [2.7 "thoughts"] V0.3
Date: Fri, 10 Oct 2003 09:54:12 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.7 "thoughts"
Thanks to Gabor, Stuart, Stephan and others
Don't hesitate to send me more or comment.

Regards,
Fabian

* slab allocation quota
* ntfs full support
* kernel web server (Interfaced to Roman config tool)
* ipc to sysfs
* complete user quota centralization
* Add _responsibilities_ for virtual process tree and possible
relation in oops cases
* Does the whole proc vm stuff root/box relevant ?I don't think
so....Hence, those proc entries deserve security relevant attributes
* Devices should be limited as well against bad usage(floppy defect),
viral activity(netcard rush)...
* Improve kobject model for security, quota rendering
* bind mount support for all general mount options (nodev,ro,noexec etc)
  with SECURE implementation with any (maybe even future) filesystems?
* union mount (possible with option to declare on what fs a new file
  should be created: on fixed ones, random algorithm, on fs with the
  largest free space available etc ...)
* guaranteed i/o bandwidth allocation?
* netfilter's ability to do tricks which OpenBSD can do now with its
  packet filter
* ENBD support in official kernel with enterprise-class 'through the
  network' volume management
* Standard kernel output (Minimum, Full options ...)
* Virtual machine support
* /proc interface alternative to modutils/module-init-tools.
                That is, to have a directory of virtual nodes in /proc
                to provide the functionality of insmod, rmmod, lsmod &
                modprobe would be great -- especially from the viewpoint
                of recue disk images, etc.
* Software RAID 0+1 perhaps?
                A lot of hardware RAID cards support it, why not the
                kernel?  By RAID 0+1 I mean mirror-RAIDing two (or more)
                stripe-RAID arrays.  (Or can this be done already?)
* Transparent Software-RAID for IDE RAID cards...
                This could be done by using the Software RAID
                functionality of the kernel, but making the RAID
                interface transparent, so you only see a /dev/md?
                device, rather than multiple /dev/?da* entries.
* hotplug RAM
