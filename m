Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263494AbTJ0Umb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTJ0Umb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:42:31 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47601 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263494AbTJ0Um3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:42:29 -0500
Message-ID: <3F9D8332.3060003@mvista.com>
Date: Mon, 27 Oct 2003 13:42:26 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ANNOUNCE: User-space System Device Enumeration (uSDE)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initial availability of User-Space System Device Enumeration (uSDE) 
package, version 0.74, can be found at http://sourceforge.net/projects/usde

The uSDE provides an open framework for the enumeration (specification) 
of system devices in a dynamic environment. Device handling is 
implemented via plug-in programs known as policy methods. Policy methods 
are free to handle their devices in any way, from trivial to complex - 
anything from providing LSB device nodes to persistent device name 
handling with
replacement and relocation strategies.

The uSDE depends on /sbin/hotplug (for dynamic insertions and removals), 
sysfs (for device information) and /proc (various pieces of 
information). It is not dependent on initrd - it explicitly scans sysfs 
upon system startup to determine the initial device ensemble.

Part of the uSDE release is a collection of sample polices:

disk-ide-policy - handles IDE, EIDE, SATA and USB-EIDE disks. Implements 
persistent device naming, automatic device replacement and automatic 
device relocation features.

disk-scsi-policy - handles SCSI, IEEE-1394, FibreChannel and USB-SCSI 
disks including multiported devices. Iplements persistent device naming, 
automatic device replacement and automatic device relocation features.

multipath-policy - handles the automatic provisioning of multipathing 
for multiported storage devices.

ethernet-policy - handles ethernet interefaces. Implements persistent 
interface naming, interface anchoring, automatic device replacement and 
automatic device relocation features.

floppy-policy - handles internal floppy disks.

simple-device-policy - a "catch all" policy for block and character devices.

devfs-policy - provides devfs device names.

lsb-policy - provides LSB device names.


Location:       http://sourceforge.net/projects/usde
Mailing list:   usde-general@lists.sourceforge.net

mark


