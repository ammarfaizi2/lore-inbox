Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVJ1Gbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVJ1Gbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbVJ1Gbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:49386 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965152AbVJ1Gb1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:27 -0400
Cc: erik@hovland.org
Subject: [PATCH] changes device to driver in porting.txt
In-Reply-To: <11304810213311@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:22 -0700
Message-Id: <11304810221164@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] changes device to driver in porting.txt

The document porting.txt in Documentation/driver-model says:
When a device is successfully bound to a device

I think it should say:
When a device is successfully bound to a driver

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3da2cf413a832ae4f7691d299f2d7dab30654ce5
tree 1808e0383651b708d22038756f87796b5806a9fc
parent 3ab05c2cd849f4fdee6e79cc9f63d11de6ad63d9
author Erik Hovland <erik@hovland.org> Thu, 06 Oct 2005 10:47:49 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:47:59 -0700

 Documentation/driver-model/porting.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/driver-model/porting.txt b/Documentation/driver-model/porting.txt
index ff2fef2..98b233c 100644
--- a/Documentation/driver-model/porting.txt
+++ b/Documentation/driver-model/porting.txt
@@ -350,7 +350,7 @@ When a driver is registered, the bus's l
 over. bus->match() is called for each device that is not already
 claimed by a driver. 
 
-When a device is successfully bound to a device, device->driver is
+When a device is successfully bound to a driver, device->driver is
 set, the device is added to a per-driver list of devices, and a
 symlink is created in the driver's sysfs directory that points to the
 device's physical directory:

