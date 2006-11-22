Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756969AbWKVIAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969AbWKVIAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756970AbWKVIAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:00:07 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:7110 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1756973AbWKVIAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:00:06 -0500
Date: Wed, 22 Nov 2006 00:00:03 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Eric.Moore@lsil.com, mpt_linux_developer@lsil.com,
       markus.lidel@shadowconnect.com, akpm <akpm@osdl.org>
Subject: [PATCH 1/3] kernel-doc: add fusion and i2o to kernel-api book
Message-Id: <20061122000003.8928a29c.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Add Fusion and I2O message-based device interfaces to kernel-api book.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/DocBook/kernel-api.tmpl |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- linux-2619-rc6g4.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2619-rc6g4/Documentation/DocBook/kernel-api.tmpl
@@ -423,6 +423,37 @@ X!Edrivers/pnp/system.c
 !Edrivers/media/video/videodev.c
   </chapter>
 
+  <chapter id="message_devices">
+	<title>Message-based devices</title>
+     <sect1><title>Fusion message devices</title>
+!Edrivers/message/fusion/mptbase.c
+!Idrivers/message/fusion/mptbase.c
+!Edrivers/message/fusion/mptscsih.c
+!Idrivers/message/fusion/mptscsih.c
+!Idrivers/message/fusion/mptctl.c
+!Idrivers/message/fusion/mptspi.c
+!Idrivers/message/fusion/mptfc.c
+!Idrivers/message/fusion/mptlan.c
+     </sect1>
+     <sect1><title>I2O message devices</title>
+!Iinclude/linux/i2o.h
+!Idrivers/message/i2o/core.h
+!Edrivers/message/i2o/iop.c
+!Idrivers/message/i2o/iop.c
+!Idrivers/message/i2o/config-osm.c
+!Edrivers/message/i2o/exec-osm.c
+!Idrivers/message/i2o/exec-osm.c
+!Idrivers/message/i2o/bus-osm.c
+!Edrivers/message/i2o/device.c
+!Idrivers/message/i2o/device.c
+!Idrivers/message/i2o/driver.c
+!Idrivers/message/i2o/pci.c
+!Idrivers/message/i2o/i2o_block.c
+!Idrivers/message/i2o/i2o_scsi.c
+!Idrivers/message/i2o/i2o_proc.c
+     </sect1>
+  </chapter>
+
   <chapter id="snddev">
      <title>Sound Devices</title>
 !Iinclude/sound/core.h


---
