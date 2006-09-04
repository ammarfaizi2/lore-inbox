Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWIDXRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWIDXRO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbWIDXRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:17:13 -0400
Received: from qb-out-0506.google.com ([72.14.204.234]:63033 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965034AbWIDXQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:16:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=BHo5Tk7g3ZTDY7GLbxDP2ACfylGTWwAfeI0SxSuSndU1MZ0Y6FGFXxQ12ilx/0YwqfqVvFuHyPwIgAmhT0XOtVDT620C2n3rPTAdGtsIBE9WQzLeT7cV9gbZo6F91deSHDzj9645EXg2e3oDILPeyeMQHnlCkCvozVgZ3fe2MPw=
Date: Tue, 5 Sep 2006 03:16:39 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/SubmittingDrivers: minor update
Message-ID: <20060904231639.GC5200@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* fix copright typo
* remove trailing whitespace
* remove Kernel Traffic from Resources. Zack, it was great reading!
* Name Arjan by name and fix URL of "How to NOT" paper.
* Remove "Last updated" tag.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/SubmittingDrivers |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

--- a/Documentation/SubmittingDrivers
+++ b/Documentation/SubmittingDrivers
@@ -59,11 +59,11 @@ Copyright:	The copyright owner must agre
 		are the same person/entity. If not, the name of
 		the person/entity authorizing use of GPL should be
 		listed in case it's necessary to verify the will of
-		the copright owner.
+		the copyright owner.
 
 Interfaces:	If your driver uses existing interfaces and behaves like
 		other drivers in the same class it will be much more likely
-		to be accepted than if it invents gratuitous new ones. 
+		to be accepted than if it invents gratuitous new ones.
 		If you need to implement a common API over Linux and NT
 		drivers do it in userspace.
 
@@ -88,7 +88,7 @@ Clarity:	It helps if anyone can see how 
 		it will go in the bitbucket.
 
 Control:	In general if there is active maintainance of a driver by
-		the author then patches will be redirected to them unless 
+		the author then patches will be redirected to them unless
 		they are totally obvious and without need of checking.
 		If you want to be the contact and update point for the
 		driver it is a good idea to state this in the comments,
@@ -100,7 +100,7 @@ What Criteria Do Not Determine Acceptanc
 Vendor:		Being the hardware vendor and maintaining the driver is
 		often a good thing. If there is a stable working driver from
 		other people already in the tree don't expect 'we are the
-		vendor' to get your driver chosen. Ideally work with the 
+		vendor' to get your driver chosen. Ideally work with the
 		existing driver author to build a single perfect driver.
 
 Author:		It doesn't matter if a large Linux company wrote the driver,
@@ -116,17 +116,13 @@ Linux kernel master tree:
 	ftp.??.kernel.org:/pub/linux/kernel/...
 	?? == your country code, such as "us", "uk", "fr", etc.
 
-Linux kernel mailing list:		
+Linux kernel mailing list:
 	linux-kernel@vger.kernel.org
 	[mail majordomo@vger.kernel.org to subscribe]
 
 Linux Device Drivers, Third Edition (covers 2.6.10):
 	http://lwn.net/Kernel/LDD3/  (free version)
 
-Kernel traffic:
-	Weekly summary of kernel list activity (much easier to read)
-	http://www.kerneltraffic.org/kernel-traffic/
-
 LWN.net:
 	Weekly summary of kernel development activity - http://lwn.net/
 	2.6 API changes:
@@ -145,11 +141,8 @@ KernelNewbies:
 Linux USB project:
 	http://www.linux-usb.org/
 
-How to NOT write kernel driver by arjanv@redhat.com
-	http://people.redhat.com/arjanv/olspaper.pdf
+How to NOT write kernel driver by Arjan van de Ven:
+	http://www.fenrus.org/how-to-not-write-a-device-driver-paper.pdf
 
 Kernel Janitor:
 	http://janitor.kernelnewbies.org/
-
---
-Last updated on 17 Nov 2005.

