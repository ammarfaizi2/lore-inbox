Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWGUJDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWGUJDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 05:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWGUJDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 05:03:24 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:26770 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030423AbWGUJDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 05:03:23 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Martin Waitz <tali@admingilde.org>
Subject: [PATCH][Doc] Fix parameter names in drivers/base/class.c
Date: Fri, 21 Jul 2006 11:04:43 +0200
User-Agent: KMail/1.9.3
Cc: Randy Dunlap <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607211104.43379.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change parameter names to match arguments of functions.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit bcc1d90c34aa815e6f96b7f45d2dda1802e36f68
tree 5f5f6815eca9114a12efa99d4cb3fac9d42ade58
parent 71f5e8f5ba65ff8f743095017e6a44f1b6f9fe51
author Rolf Eike Beer <eike-kernel@sf-tec.de> Fri, 21 Jul 2006 11:02:51 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Fri, 21 Jul 2006 11:02:51 +0200

 drivers/base/class.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index de89083..89f824e 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -226,7 +226,7 @@ error:
 
 /**
  * class_destroy - destroys a struct class structure
- * @cs: pointer to the struct class that is to be destroyed
+ * @cls: pointer to the struct class that is to be destroyed
  *
  * Note, the pointer to be destroyed must have been created with a call
  * to class_create().
@@ -656,9 +656,9 @@ int class_device_register(struct class_d
 
 /**
  * class_device_create - creates a class device and registers it with sysfs
- * @cs: pointer to the struct class that this device should be registered to.
+ * @cls: pointer to the struct class that this device should be registered to.
  * @parent: pointer to the parent struct class_device of this new device, if any.
- * @dev: the dev_t for the char device to be added.
+ * @devt: the dev_t for the char device to be added.
  * @device: a pointer to a struct device that is assiociated with this class device.
  * @fmt: string for the class device's name
  *
@@ -763,7 +763,7 @@ void class_device_unregister(struct clas
 /**
  * class_device_destroy - removes a class device that was created with class_device_create()
  * @cls: the pointer to the struct class that this device was registered * with.
- * @dev: the dev_t of the device that was previously registered.
+ * @devt: the dev_t of the device that was previously registered.
  *
  * This call unregisters and cleans up a class device that was created with a
  * call to class_device_create()
