Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTJNKCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 06:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTJNKCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 06:02:16 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:29404 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S262101AbTJNKCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 06:02:10 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [2.7TH 0.4]Thoughts
From: <ffrederick@prov-liege.be>
Date: Mon, 13 Oct 2003 12:02:52 PDT
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S262101AbTJNKCK/20031014100210Z+13761@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.7TH0.4 (thoughts)

Thanks to Gabor, Stuart, Stephan and others
Don't hesitate to send me more or comments !

Ok, stuff has been sorted and some links added.

Regards,
Fabian

-------------------------------------------------------------------------------
Mandatory features

* Hotplug CPU (Done experimental against 2.4.X) - RAM
* Standard kernel building (Minimum, Full options, Detection ...)
* LVM (http://www.vinumvm.org)
* Slab allocation quota
* Ntfs full support
* Kernel Web - Gopher server 
	-Interfaced to Zippel config tool
	-http://fabian.unixtech.be/kernel/ks.html
* Complete user quota centralization
* Add _responsibilities_ for virtual process tree and possible
relation in oops cases
* Does the whole proc vm stuff root/box relevant ?I don't think
so....Hence, those proc entries deserve security relevant attributes
* Devices should be limited as well against bad usage(floppy defect),
viral activity(netcard rush)...
* Improve kobject model for security, quota rendering
* Bind mount support for all general mount options (nodev,ro,noexec etc)
  with SECURE implementation with any (maybe even future) filesystems?
* Guaranteed i/o bandwidth allocation
* Netfilter's ability to do tricks which OpenBSD can do now with its
  packet filter
* ENBD support in official kernel with enterprise-class 'through the
  network' volume management
* /proc interface alternative to modutils/module-init-tools.
                That is, to have a directory of virtual nodes in /proc
                to provide the functionality of insmod, rmmod, lsmod &
                modprobe would be great -- especially from the viewpoint
                of recue disk images, etc.
* Virtual machine support
* IPC to sysfs (http://fabian.unixtech.be/kernel/ipctosysfs.html)

-------------------------------------------------------------------------------

More informations needed:

* Kernel object model :
	-What's wrong with kobject ?

-------------------------------------------------------------------------------

Already in:

* Software RAID 0+1 perhaps?
                A lot of hardware RAID cards support it, why not the
                kernel?  By RAID 0+1 I mean mirror-RAIDing two (or more)
                stripe-RAID arrays.  (Or can this be done already?)
Kevin :
This can be done using evms, mdadm, raidtools

-------------------------------------------------------------------------------


___________________________________



