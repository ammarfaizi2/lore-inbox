Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTLBTVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTLBTVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:21:30 -0500
Received: from host213.137.0.249.manx.net ([213.137.0.249]:44043 "EHLO server")
	by vger.kernel.org with ESMTP id S264321AbTLBTV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:21:26 -0500
Date: Tue, 2 Dec 2003 19:21:26 +0000
From: Matthew Bell <m.bell@bvrh.co.uk>
To: twaugh@redhat.com, linux-parport@torque.net, linux-kernel@vger.kernel.org
Subject: [2.4][PATCH][OBVIOUS] parport_serial.o; Config.in:
 CONFIG_PARPORT_SERIAL should depend on CONFIG_PCI
Message-Id: <20031202192126.2f7359d8.m.bell@bvrh.co.uk>
Organization: Beach View Residential Home, Ltd.
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server-25665-1070392882-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server-25665-1070392882-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Patch is attached as text/plain.

Matthew W. S. Bell

--=_server-25665-1070392882-0001-2
Content-Type: text/plain; name="parport.diff"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="parport.diff"

--- linux.orig/drivers/parport/Config.in	2001-12-21 17:41:55.000000000 +0000
+++ linux/drivers/parport/Config.in	2002-08-06 18:52:21.000000000 +0100
@@ -17,7 +17,7 @@
       else
          define_tristate CONFIG_PARPORT_PC_CML1 $CONFIG_PARPORT_PC
       fi
-      dep_tristate '    Multi-IO cards (parallel and serial)' CONFIG_PARPORT_SERIAL $CONFIG_PARPORT_PC_CML1
+      dep_tristate '    Multi-IO cards (parallel and serial)' CONFIG_PARPORT_SERIAL $CONFIG_PARPORT_PC_CML1 $CONFIG_PCI
    fi
    if [ "$CONFIG_PARPORT_PC" != "n" ]; then
       if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then

--=_server-25665-1070392882-0001-2--
