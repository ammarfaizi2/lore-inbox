Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUJNLbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUJNLbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 07:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUJNLbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 07:31:37 -0400
Received: from main.gmane.org ([80.91.229.2]:7319 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263540AbUJNLbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 07:31:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ganesan R <rganesan@myrealbox.com>
Subject: Linux 2.6.x wrongly recognizes USB 2.0 DVD writer
Date: Thu, 14 Oct 2004 11:14:44 +0000 (UTC)
Message-ID: <ckln33$c3e$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: grajagop-lnx.cisco.com
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a NEC ND-2500A DVD writer in a ByteCC USB 2.0 external enclosure.
It's recognized perfectly in 2.4.27 (Debian kernel-image-2.4.27-1-686
package)

========
scsi2 : SCSI emulation for USB Mass Storage
   Vendor: _NEC      Model: DVD_RW ND-2500A
   Type:   CD-ROM    ANSI SCSI revision: 02
Attached scsi CD-ROM sr1 at scsi2, channel 0, id 0, lun 0
sr1: scsi-1 drive
USB Mass Storage support registered.
========

When I boot 2.6.8 (Debian kernel-image-2.6.8-1-686 package), I get

========
scsi3 : SCSI emulation for USB Mass Storage devices
  Vendor: Revoltec  Model: USB/IDE Bridge (  Rev: 0103
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdb at scsi3, channel 0, id 0, lun 0
USB Mass Storage device found at 4
========

Any body else facing this problem?

Ganesan
    
  

