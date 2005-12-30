Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVL3NxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVL3NxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 08:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVL3NxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 08:53:13 -0500
Received: from zorg.st.net.au ([203.16.233.9]:10188 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1751263AbVL3NxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 08:53:12 -0500
Message-ID: <43B53C21.7050108@torque.net>
Date: Fri, 30 Dec 2005 23:54:41 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, taggart@debian.org
Subject: lsscsi-0.16 released
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsscsi is a utility that uses sysfs in linux 2.6 series kernels
to list information about all SCSI devices and SCSI hosts. Both a
compact format (default) which is one line
per device and a "classic" format (like the output of
'cat /proc/scsi/scsi') are supported. Some examples:

$ lsscsi
[0:0:0:0]    disk    Linux    scsi_debug       0004  /dev/sda
[1:0:6:0]    tape    SONY     SDT-7000         0192  /dev/st0

$ lsscsi --classic
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Linux    Model: scsi_debug       Rev: 0004
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: SONY     Model: SDT-7000         Rev: 0192
  Type:   Sequential-Access                ANSI SCSI revision: 02

Version 0.16 is available at
http://www.torque.net/scsi/lsscsi.html
[See Download section for tarball and rpm]

No major changes. ChangeLog:

Version 0.16 2005/12/30
  - clean up peripheral device type naming
  - properly identify osst and (tape) changer devices
  - add debian build directory

Doug Gilbert
