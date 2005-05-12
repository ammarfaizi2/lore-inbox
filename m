Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVELM6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVELM6B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVELMzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:55:24 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:5689 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261864AbVELMyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:54:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NSkFAb+bxwNug8uopX6BE794O6GvWfpZHqT72yJAfWU9Jc/xdZojlWgwNGaY4WJkYKRwC0v/QUqkWLXuvEqdhtG5mKa2HoJIuvjOxpPoaMWuOAtrXSaR8Vhsk6R2zxGl3O2O7lZDV6Iy2LRNnu79y732nJhAywDjFV1XBn8L4r8=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: kobject_register failed for intelfb (-EACCES) (Re: 2.6.12-rc4-mm1)
Date: Thu, 12 May 2005 16:58:01 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050512033100.017958f6.akpm@osdl.org>
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505121658.02019.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 May 2005 14:31, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm1/

Was not present in 2.6.12-rc4.

Linux agpgart interface v0.101 (c) Dave Jones
kobject agpgart-intel: registering. parent: <NULL>, set: drivers
kobject_hotplug
fill_kobj_path: path = '/bus/pci/drivers/agpgart-intel'
kobject_hotplug: /sbin/hotplug drivers seq=200 HOME=/
PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add
DEVPATH=/bus/pci/drivers/agpgart-intel SUBSYSTEM=drivers
kobject_hotplug - call_usermodehelper returned -1
agpgart: Detected an Intel 865 Chipset.
agpgart: Detected 16252K stolen memory.
kobject agpgart: registering. parent: misc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/misc/agpgart'
kobject_hotplug: /sbin/hotplug misc seq=201 HOME=/
PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/misc/agpgart
SUBSYSTEM=misc
kobject_hotplug - call_usermodehelper returned -1
agpgart: AGP aperture is 128M @ 0xf0000000
subsystem drm: registering
kobject drm: registering. parent: <NULL>, set: class
[drm] Initialized drm 1.0.0 20040925
kobject card0: registering. parent: drm, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/drm/card0'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:02.0'
kobject_hotplug: /sbin/hotplug drm seq=202 HOME=/
PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/drm/card0
SUBSYSTEM=drm
kobject_hotplug - call_usermodehelper returned -1
[drm] Initialized i915 1.1.0 20040405 on minor 0:
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G
chipsets
intelfb: Version 0.9.2
kobject Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver:
registering. parent: <NULL>, set: drivers
kobject_register failed for Intel(R) 830M/845G/852GM/855GM/865G/915G
Framebuffer Driver (-13)
 [<c01bf8e3>] kobject_register+0x43/0x70
 [<c022dfe2>] bus_add_driver+0x52/0xa0
 [<c01c8c10>] pci_device_shutdown+0x0/0x20
 [<c01c8d71>] pci_register_driver+0x61/0x80
 [<c0387099>] intelfb_init+0x59/0x70
 [<c03787cc>] do_initcalls+0x2c/0xc0
 [<c0159025>] kern_mount+0x15/0x17
 [<c01002a0>] init+0x0/0x100
 [<c01002ca>] init+0x2a/0x100
 [<c0100f58>] kernel_thread_helper+0x0/0x18
 [<c0100f5d>] kernel_thread_helper+0x5/0x18
