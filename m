Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWFSA1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWFSA1l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 20:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWFSA1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 20:27:41 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:26213 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750804AbWFSA1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 20:27:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Nu/CIJbPvTitEVqzFuHvrcsb7jhBpS8p76ipSwcBF0ney+HS0a8r7FIiK+dvO8IzGjy7+V4WfnITkURpEb50sW+0COMBsYfnEuYNqzv6oXXlm3yxiXF2tmJVHo6G0RUWSnfVRuK8G/rc3BhZvcWxTIbb9MC9B3YpzZRf5yZAjWw=
Message-ID: <7aa969290606181727n57850e4en10957e230942c5b3@mail.gmail.com>
Date: Sun, 18 Jun 2006 20:27:39 -0400
From: "Francisco Loaiza" <floaiza@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: usb 5-1: device descriptor read/64, error -110
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Summary of the problem:  Attempt to connect Hitachi usb HDD fails

[2.] Full description of the problem/report:
Jun 18 20:16:00 localhost kernel:   Type:   Direct-Access
        ANSI                              SCSI revision: 00
Jun 18 20:16:00 localhost kernel: SCSI device sda: 156301489 512-byte
hdwr sectors (                             80026 MB)
Jun 18 20:16:00 localhost kernel: sda: Write Protect is off
Jun 18 20:16:00 localhost kernel: sda: assuming drive cache: write through
Jun 18 20:16:00 localhost kernel: SCSI device sda: 156301489 512-byte
hdwr sectors (                             80026 MB)
Jun 18 20:16:00 localhost kernel: sda: Write Protect is off
Jun 18 20:16:00 localhost kernel: sda: assuming drive cache: write through
Jun 18 20:16:01 localhost kernel:  sda: sda1
Jun 18 20:16:01 localhost kernel: sd 5:0:0:0: Attached scsi disk sda
Jun 18 20:16:01 localhost kernel: sd 5:0:0:0: Attached scsi generic sg0 type 0
Jun 18 20:17:01 localhost kernel: usb 5-1: reset high speed USB device
using ehci_hcd and address                 25
Jun 18 20:17:04 localhost kernel: usb 5-1: device descriptor read/64, error -110
Jun 18 20:17:19 localhost kernel: usb 5-1: device descriptor read/64, error -110
Jun 18 20:17:20 localhost kernel: usb 5-1: USB disconnect, address 25
Jun 18 20:17:20 localhost kernel:  5:0:0:0: scsi: Device offlined -
not ready after error recover                y
Jun 18 20:17:20 localhost kernel:  5:0:0:0: SCSI error: return code = 0x10000
Jun 18 20:17:20 localhost kernel: end_request: I/O error, dev sda,
sector 156301488
Jun 18 20:17:20 localhost kernel: printk: 489 messages suppressed.
Jun 18 20:17:20 localhost kernel: Buffer I/O error on device sda,
logical block 156301488
Jun 18 20:17:20 localhost kernel:  5:0:0:0: rejecting I/O to dead device
Jun 18 20:17:20 localhost kernel: Buffer I/O error on device sda,
logical block 156301488
Jun 18 20:17:20 localhost kernel:  5:0:0:0: rejecting I/O to dead device
Jun 18 20:17:20 localhost kernel: Buffer I/O error on device sda,
logical block 156301488
Jun 18 20:17:20 localhost kernel:  5:0:0:0: rejecting I/O to dead device
Jun 18 20:17:20 localhost kernel: Buffer I/O error on device sda,
logical block 156301488
Jun 18 20:17:20 localhost kernel:  5:0:0:0: rejecting I/O to dead device
Jun 18 20:17:20 localhost kernel: Buffer I/O error on device sda,
logical block 156301424
Jun 18 20:17:20 localhost kernel: Buffer I/O error on device sda,
logical block 156301425
Jun 18 20:17:20 localhost kernel: Buffer I/O error on device sda,
logical block 156301426
Jun 18 20:17:20 localhost kernel: Buffer I/O error on device sda,
logical block 156301427
Jun 18 20:17:20 localhost kernel: Buffer I/O error on device sda,
logical block 156301428
Jun 18 20:17:20 localhost kernel: Buffer I/O error on device sda,
logical block 156301429
Jun 18 20:17:20 localhost kernel:  5:0:0:0: rejecting I/O to dead device
Jun 18 20:17:20 localhost last message repeated 30 times
Jun 18 20:17:20 localhost kernel: usb 5-1: new high speed USB device
using ehci_hcd and address 2                6
Jun 18 20:17:23 localhost kernel: usb 5-1: device descriptor read/64, error -110
Jun 18 20:17:38 localhost kernel: usb 5-1: device descriptor read/64, error -110
Jun 18 20:17:39 localhost kernel: usb 5-1: new high speed USB device
using ehci_hcd and address 28
Jun 18 20:17:42 localhost kernel: usb 5-1: device descriptor read/64, error -110
Jun 18 20:17:57 localhost kernel: usb 5-1: device descriptor read/64, error -110
Jun 18 20:17:58 localhost kernel: usb 5-1: new high speed USB device
using ehci_hcd and address 30
Jun 18 20:18:01 localhost kernel: usb 5-1: device descriptor read/64, error -110

[3.] Keywords (i.e., modules, networking, kernel): kernel usb hdd drivers

[4.] Kernel version (from /proc/version): 2.6.16-1.2133_FC5

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):
[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem

Similar problem was reported in FC4 and Alan Stern wrote a patch but
is not clear that his fix has become part of the standard release:

===== drivers/usb/storage/scsiglue.c 1.95 vs edited =====
--- 1.95/drivers/usb/storage/scsiglue.c 2005-02-10 16:22:46 -05:00
+++ edited/drivers/usb/storage/scsiglue.c       2005-02-22 10:50:08 -05:00
@@ -154,6 +154,14 @@
                 * If this device makes that mistake, tell the sd driver. */
                if (us->flags & US_FL_FIX_CAPACITY)
                        sdev->fix_capacity = 1;
+
+               /* Some devices report a SCSI revision level above 2 but are
+                * unable to handle the REPORT LUNS command (for which
+                * support is mandatory at level 3).  Since we already have
+                * a Get-Max-LUN request, we won't lose much by setting the
+                * revision level down to 2.  The only devices that would be
+                * affected are those with sparse LUNs. */
+               sdev->scsi_level = SCSI_2;
        } else {

                /* Non-disk-type devices don't need to blacklist any pages


[X.] Other notes, patches, fixes, workarounds:

-- 
Francisco Loaiza, Ph.D., J.D.
Institute for Defense Analyses
4850 Mark Center Drive
Alexandria, VA 22311

"Omnis possibilis est,
postulant tantum longius
impossibilia tempus"
