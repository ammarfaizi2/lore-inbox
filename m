Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268750AbUH3R4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268750AbUH3R4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268753AbUH3Ry7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:54:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:49386 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S266895AbUH3Rts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:49:48 -0400
Subject: 47 New compile/sparse warnings (over the weekend)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1093887916.2653.10.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 30 Aug 2004 10:45:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiler: gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
Arch: i386


Summary:
   New warnings = 47
   Fixed warnings = 44

New warnings:
-------------
drivers/message/i2o/iop.c:292:9: warning: Using plain integer as NULL
pointer

drivers/message/i2o/iop.c:981:5: warning: undefined preprocessor
identifier 'DEBUG'

drivers/scsi/megaraid/megaraid_mbox.c:2310:35: warning: Using plain
integer as NULL pointer

drivers/scsi/megaraid/megaraid_mbox.c:3842:35: warning: Using plain
integer as NULL pointer

drivers/scsi/megaraid/megaraid_mm.c:1097:19: warning: Using plain
integer as NULL pointer

drivers/scsi/megaraid/megaraid_mm.c:127:33: warning: incorrect type in
argument 2 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:127:33:    expected void const
[noderef] *from<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:127:33:    got char *<noident>

drivers/scsi/megaraid/megaraid_mm.c:211:28: warning: incorrect type in
argument 2 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:211:28:    expected void const
[noderef] *from<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:211:28:    got struct mimd
[usertype] *umimd

drivers/scsi/megaraid/megaraid_mm.c:264:29: warning: incorrect type in
argument 2 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:264:29:    expected void const
[noderef] *from<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:264:29:    got struct mimd
[usertype] *[assigned] umimd

drivers/scsi/megaraid/megaraid_mm.c:282:25: warning: incorrect type in
argument 1 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:282:25:    expected void [noderef]
*to<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:282:25:    got char *[addressable]
[toplevel] [usertype] data

drivers/scsi/megaraid/megaraid_mm.c:291:25: warning: incorrect type in
argument 1 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:291:25:    expected void [noderef]
*to<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:291:25:    got char *[addressable]
[toplevel] [usertype] data

drivers/scsi/megaraid/megaraid_mm.c:328:28: warning: incorrect type in
argument 2 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:328:28:    expected void const
[noderef] *from<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:328:28:    got struct mimd
[usertype] *umimd

drivers/scsi/megaraid/megaraid_mm.c:423:44: warning: incorrect type in
argument 2 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:423:44:    expected void const
[noderef] *from<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:423:44:    got char *[addressable]
[toplevel] [usertype] user_data

drivers/scsi/megaraid/megaraid_mm.c:442:31: warning: incorrect type in
argument 2 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:442:31:    expected void const
[noderef] *from<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:442:31:    got char *[usertype]
<noident>

drivers/scsi/megaraid/megaraid_mm.c:449:43: warning: incorrect type in
argument 2 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:449:43:    expected void const
[noderef] *from<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:449:43:    got char *[addressable]
[toplevel] [usertype] user_data

drivers/scsi/megaraid/megaraid_mm.c:479:21: warning: Using plain integer
as NULL pointer

drivers/scsi/megaraid/megaraid_mm.c:49:1: warning:
"register_ioctl32_conversion" redefined
drivers/scsi/megaraid/megaraid_mm.c:49:1: warning:
"register_ioctl32_conversion" redefined

drivers/scsi/megaraid/megaraid_mm.c:49:9: warning: preprocessor token
register_ioctl32_conversion redefined

drivers/scsi/megaraid/megaraid_mm.c:50:1: warning:
"unregister_ioctl32_conversion" redefined
drivers/scsi/megaraid/megaraid_mm.c:50:1: warning:
"unregister_ioctl32_conversion" redefined

drivers/scsi/megaraid/megaraid_mm.c:50:9: warning: preprocessor token
unregister_ioctl32_conversion redefined

drivers/scsi/megaraid/megaraid_mm.c:579:21: warning: Using plain integer
as NULL pointer

drivers/scsi/megaraid/megaraid_mm.c:583:21: warning: Using plain integer
as NULL pointer

drivers/scsi/megaraid/megaraid_mm.c:585:21: warning: Using plain integer
as NULL pointer

drivers/scsi/megaraid/megaraid_mm.c:738:29: warning: incorrect type in
argument 2 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:738:29:    expected void const
[noderef] *from<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:738:29:    got struct mimd
[usertype] *mimd

drivers/scsi/megaraid/megaraid_mm.c:754:26: warning: incorrect type in
argument 1 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:754:26:    expected void [noderef]
*to<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:754:26:    got char *[addressable]
[toplevel] [usertype] data

drivers/scsi/megaraid/megaraid_mm.c:773:21: warning: incorrect type in
argument 1 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:773:21:    expected void [noderef]
*to<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:773:21:    got void *<noident>

drivers/scsi/megaraid/megaraid_mm.c:781:24: warning: incorrect type in
argument 1 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:781:24:    expected void [noderef]
*to<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:781:24:    got char *[addressable]
[toplevel] [usertype] user_data

drivers/scsi/megaraid/megaraid_mm.c:787:20: warning: incorrect type in
argument 1 (different address spaces)
drivers/scsi/megaraid/megaraid_mm.c:787:20:    expected void [noderef]
*to<asn:1>
drivers/scsi/megaraid/megaraid_mm.c:787:20:    got void *<noident>

include/linux/ioctl32.h:32:1: warning: this is the location of the
previous definition

include/linux/ioctl32.h:33:1: warning: this is the location of the
previous definition

include/sound/emu10k1.h:940:11: warning: dubious one-bit signed bitfield
include/sound/emu10k1.h:940:11: warning: dubious bitfield without
explicit `signed' or `unsigned'

sound/pci/intel8x0.c:427:15: warning: dubious one-bit signed bitfield
sound/pci/intel8x0.c:427:15: warning: dubious bitfield without explicit
`signed' or `unsigned'

sound/pci/intel8x0.c:427:15: warning: dubious one-bit signed bitfield
sound/pci/intel8x0.c:427:15: warning: dubious bitfield without explicit
`signed' or `unsigned'

sound/usb/usx2y/usX2Yhwdep.c:218:6: warning: incorrect type in
assignment (different address spaces)
sound/usb/usx2y/usX2Yhwdep.c:218:6:    expected char *buf
sound/usb/usx2y/usX2Yhwdep.c:218:6:    got unsigned char [noderef]
*[addressable] [toplevel] [usertype] image<asn:1>

sound/usb/usx2y/usbusx2y.c:349:10: warning: Using plain integer as NULL
pointer

sound/usb/usx2y/usbusx2y.c:353:10: warning: Using plain integer as NULL
pointer

sound/usb/usx2y/usbusx2yaudio.c:414:10: warning: Using plain integer as
NULL pointer

sound/usb/usx2y/usbusx2yaudio.c:430:18: warning: Using plain integer as
NULL pointer

sound/usb/usx2y/usbusx2yaudio.c:797:28: warning: Using plain integer as
NULL pointer

sound/usb/usx2y/usbusx2yaudio.c:841:25: warning: Using plain integer as
NULL pointer

drivers/isdn/hardware/eicon/debug.c:1810:21: warning: Using plain
integer as NULL pointer

drivers/isdn/hardware/eicon/debug.c:2102:64: warning: Using plain
integer as NULL pointer

drivers/isdn/hardware/eicon/debug.c:2130:64: warning: Using plain
integer as NULL pointer

drivers/isdn/hardware/eicon/divamnt.c:147:25: warning: Using plain
integer as NULL pointer

drivers/isdn/hardware/eicon/mntfunc.c:190:42: warning: incorrect type in
argument 2 (different address spaces)
drivers/isdn/hardware/eicon/mntfunc.c:190:42:    expected void const
[noderef] *from<asn:1>
drivers/isdn/hardware/eicon/mntfunc.c:190:42:    got void *<noident>

drivers/isdn/hardware/eicon/mntfunc.c:190:52: warning: cast removes
address space of expression

drivers/isdn/hardware/eicon/mntfunc.c:202:23: warning: cast removes
address space of expression
drivers/isdn/hardware/eicon/mntfunc.c:202:23: warning: incorrect type in
argument 1 (different address spaces)
drivers/isdn/hardware/eicon/mntfunc.c:202:23:    expected void [noderef]
*to<asn:1>
drivers/isdn/hardware/eicon/mntfunc.c:202:23:    got void *<noident>

drivers/isdn/hardware/eicon/mntfunc.c:202:23: warning: cast removes
address space of expression
drivers/isdn/hardware/eicon/mntfunc.c:202:23: warning: incorrect type in
argument 1 (different address spaces)
drivers/isdn/hardware/eicon/mntfunc.c:202:23:    expected void [noderef]
*to<asn:1>
drivers/isdn/hardware/eicon/mntfunc.c:202:23:    got void *<noident>


Fixed warnings:
---------------
drivers/scsi/dc395x.c:387:39: warning: marked inline, but without a
definition

drivers/scsi/dc395x.c:393:33: warning: marked inline, but without a
definition
drivers/scsi/dc395x.c:393:33: warning: marked inline, but without a
definition
drivers/scsi/dc395x.c:393:33: warning: marked inline, but without a
definition
drivers/scsi/dc395x.c:393:33: warning: marked inline, but without a
definition

drivers/scsi/ipr.c:884:26: warning: bad constant expression

drivers/scsi/ips.c:477:37: warning: marked inline, but without a
definition
drivers/scsi/ips.c:477:37: warning: marked inline, but without a
definition

drivers/scsi/ips.c:480:38: warning: marked inline, but without a
definition

drivers/scsi/ips.c:483:38: warning: marked inline, but without a
definition

drivers/scsi/ips.c:485:46: warning: marked inline, but without a
definition
drivers/scsi/ips.c:485:46: warning: marked inline, but without a
definition
drivers/scsi/ips.c:485:46: warning: marked inline, but without a
definition

drivers/scsi/ips.c:487:47: warning: marked inline, but without a
definition
drivers/scsi/ips.c:487:47: warning: marked inline, but without a
definition

drivers/scsi/ips.c:488:42: warning: marked inline, but without a
definition
drivers/scsi/ips.c:488:42: warning: marked inline, but without a
definition
drivers/scsi/ips.c:488:42: warning: marked inline, but without a
definition

drivers/scsi/ips.c:489:53: warning: marked inline, but without a
definition
drivers/scsi/ips.c:489:53: warning: marked inline, but without a
definition

drivers/scsi/ips.c:491:58: warning: marked inline, but without a
definition

drivers/scsi/tmscsim.c:294:42: warning: marked inline, but without a
definition

drivers/scsi/tmscsim.c:295:40: warning: marked inline, but without a
definition

drivers/scsi/tmscsim.c:296:49: warning: marked inline, but without a
definition

drivers/usb/gadget/inode.c:587:19: warning: Using plain integer as NULL
pointer

drivers/usb/gadget/inode.c:706:47: warning: Using plain integer as NULL
pointer

drivers/scsi/libata-scsi.c:97:10: warning: cast removes address space of
expression

sound/oss/ad1848.c:1581: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/ad1848.c:2531: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/cs4232.c:141: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/mad16.c:322: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/maui.c:307: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)

sound/oss/mpu401.c:1215: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/opl3sa.c:114: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/opl3sa.c:122: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/pss.c:1038: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)

sound/oss/pss.c:191: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)

sound/oss/pss.c:744: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)

sound/oss/sb_common.c:523: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)

sound/oss/sgalaxy.c:89: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/sgalaxy.c:97: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/sscape.c:1118: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/sscape.c:1137: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/sscape.c:1142: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/sscape.c:742: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/oss/trix.c:147: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)

sound/oss/trix.c:292: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)

sound/oss/trix.c:85: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)

sound/oss/wf_midi.c:787: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

sound/pci/rme9652/hdsp.c:624:38: warning: marked inline, but without a
definition

sound/pci/rme9652/hdsp.c:625:51: warning: marked inline, but without a
definition

sound/pci/rme9652/hdsp.c:626:49: warning: marked inline, but without a
definition

sound/pci/rme9652/hdsp.c:627:33: warning: marked inline, but without a
definition
sound/pci/rme9652/hdsp.c:627:33: warning: marked inline, but without a
definition
sound/pci/rme9652/hdsp.c:627:33: warning: marked inline, but without a
definition
sound/pci/rme9652/hdsp.c:627:33: warning: marked inline, but without a
definition
sound/pci/rme9652/hdsp.c:627:33: warning: marked inline, but without a
definition
sound/pci/rme9652/hdsp.c:627:33: warning: marked inline, but without a
definition

sound/pci/rme9652/hdsp.c:630:47: warning: marked inline, but without a
definition



