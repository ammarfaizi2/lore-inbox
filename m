Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbTJHNf7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTJHNel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:34:41 -0400
Received: from mail.convergence.de ([212.84.236.4]:7393 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261535AbTJHN25 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:28:57 -0400
Subject: [PATCH 6/14] update copyright and licensing
In-Reply-To: <1065619733696@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 8 Oct 2003 15:28:55 +0200
Message-Id: <10656197352583@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] - fix copyright stuff in various files:
  - remove e-mail addresses that don't exist anymore, but of course keep the names
  - change license from GPL to LGPL in dvb_i2c.h (Convergence code)
  - change license from GPL to LGPL in dvb_ringbuffer.h (ack by original author Oliver Endriss)
  - add LGPL license to dvb_functions
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/demux.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/demux.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/demux.h	2003-07-14 05:32:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/demux.h	2003-08-25 12:16:12.000000000 +0200
@@ -1,4 +1,5 @@
-/* demux.h 
+/* 
+ * demux.h 
  *
  * Copyright (c) 2002 Convergence GmbH
  * 
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dmxdev.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/dmxdev.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dmxdev.h	2003-07-14 05:39:29.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dmxdev.h	2003-08-25 12:16:12.000000000 +0200
@@ -1,9 +1,8 @@
 /* 
  * dmxdev.h
  *
- * Copyright (C) 2000 Ralph  Metzler <ralph@convergence.de>
- *                  & Marcus Metzler <marcus@convergence.de>
-                      for convergence integrated media GmbH
+ * Copyright (C) 2000 Ralph Metzler & Marcus Metzler
+ *                    for convergence integrated media GmbH
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public License
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.h	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvbdev.h	2003-08-25 12:16:12.000000000 +0200
@@ -1,9 +1,8 @@
 /* 
  * dvbdev.h
  *
- * Copyright (C) 2000 Ralph  Metzler <ralph@convergence.de>
- *                  & Marcus Metzler <marcus@convergence.de>
-                      for convergence integrated media GmbH
+ * Copyright (C) 2000 Ralph Metzler & Marcus Metzler
+ *                    for convergence integrated media GmbH
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Lesser Public License
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_ringbuffer.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_ringbuffer.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_ringbuffer.h	2003-07-14 05:39:26.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_ringbuffer.h	2003-08-25 12:16:12.000000000 +0200
@@ -5,28 +5,22 @@
  * Copyright (C) 2003 Oliver Endriss 
  * 
  * based on code originally found in av7110.c:
- * Copyright (C) 1999-2002 Ralph  Metzler 
- *                       & Marcus Metzler for convergence integrated media GmbH
+ * Copyright (C) 1999-2002 Ralph Metzler & Marcus Metzler
+ *                         for convergence integrated media GmbH
  *
  * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1
  * of the License, or (at your option) any later version.
  * 
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  * 
- *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
- * 
- *
- * the project's page is at http://www.linuxtv.org/dvb/
  */
 
 #ifndef _DVB_RINGBUFFER_H_
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_net.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_net.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_net.h	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_net.h	2003-08-25 12:16:12.000000000 +0200
@@ -1,8 +1,7 @@
 /* 
  * dvb_net.h
  *
- * Copyright (C) 2001 Convergence integrated media GmbH
- *                    Ralph Metzler <ralph@convergence.de>
+ * Copyright (C) 2001 Ralph Metzler for convergence integrated media GmbH
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public License
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_i2c.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_i2c.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_i2c.h	2003-07-14 05:31:51.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_i2c.h	2003-08-25 12:16:12.000000000 +0200
@@ -4,8 +4,8 @@
  * Copyright (C) 2002 Holger Waechtler for convergence integrated media GmbH
  *
  * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1
  * of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
@@ -13,10 +13,9 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
  */
 
 #ifndef _DVB_I2C_H_
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_functions.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_functions.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_functions.h	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_functions.h	2003-08-25 12:16:12.000000000 +0200
@@ -1,3 +1,26 @@
+/* 
+ * dvb_functions.h: isolate some Linux specific stuff from the dvb-core
+ *                  that can't be expressed as a one-liner
+ *                  in order to make porting to other environments easier
+ *
+ * Copyright (C) 2003 Convergence GmbH
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Lesser Public License
+ * as published by the Free Software Foundation; either version 2.1
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ */
+
 #ifndef __DVB_FUNCTIONS_H__
 #define __DVB_FUNCTIONS_H__
 
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_demux.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_demux.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_demux.h	2003-07-14 05:32:44.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_demux.h	2003-08-25 12:16:12.000000000 +0200
@@ -1,8 +1,7 @@
 /* 
- * dvb_demux.h - DVB kernel demux API
+ * dvb_demux.h: DVB kernel demux API
  *
- * Copyright (C) 2000-2001 Marcus Metzler <marcus@convergence.de>
- *                       & Ralph  Metzler <ralph@convergence.de>
+ * Copyright (C) 2000-2001 Marcus Metzler & Ralph Metzler
  *                         for convergence integrated media GmbH
  *
  * This program is free software; you can redistribute it and/or
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_filter.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_filter.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_filter.h	2003-07-14 05:31:51.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_filter.h	2003-08-25 12:16:12.000000000 +0200
@@ -1,3 +1,23 @@
+/*
+ * dvb_filter.h
+ *
+ * Copyright (C) 2003 Convergence GmbH
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
 #ifndef _DVB_FILTER_H_
 #define _DVB_FILTER_H_
 
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_frontend.h linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_frontend.h
--- xx-linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_frontend.h	2003-07-14 05:38:37.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/dvb-core/dvb_frontend.h	2003-08-25 12:16:12.000000000 +0200
@@ -1,9 +1,9 @@
 /* 
- * dvb-core.h
+ * dvb_frontend.h
+ *
+ * Copyright (C) 2001 Ralph Metzler for convergence integrated media GmbH
+ *                    overhauled by Holger Waechtler for Convergence GmbH
  *
- * Copyright (C) 2001 Ralph  Metzler <ralph@convergence.de>
- *                    overhauled by Holger Waechtler <holger@convergence.de>
- *                    for convergence integrated media GmbH
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public License

