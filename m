Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVEQK5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVEQK5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 06:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVEQK5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 06:57:06 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:50818 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261376AbVEQKpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:45:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=NsjYlbaGPuEr/0RmyL3wbd5AO+VD4ZRnONMwThaFKf0enETB5Gbt8PLnXiHGn/wjRySZGJamFAxDlTtNvW8izs9NN1pUT9V1tFVCXC0r9qKev+OKE1azWqMgTOduvmbb7oxGnB/7XcB/RB2i7YJqFl+3EdxZSvtse/AIQ/RDKq8=
Message-ID: <2538186705051703441093903a@mail.gmail.com>
Date: Tue, 17 May 2005 06:44:59 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: [PATCH 2.6.12-rc4 13/15] include: update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_296_738199.1116326699774"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_296_738199.1116326699774
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_296_738199.1116326699774
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-include.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-include.diff.diffstat.txt"

 ocp.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


------=_Part_296_738199.1116326699774
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-include.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-include.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/asm-ppc/ocp.h linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/include/asm-ppc/ocp.h
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/include/asm-ppc/ocp.h	2005-05-16 20:36:26.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/include/asm-ppc/ocp.h	2005-05-16 23:45:53.000000000 -0400
@@ -189,7 +189,7 @@ extern void ocp_for_each_device(void(*ca
 /* Sysfs support */
 #define OCP_SYSFS_ADDTL(type, format, name, field)			\
 static ssize_t								\
-show_##name##_##field(struct device *dev, char *buf)			\
+show_##name##_##field(struct device *dev, struct device_attribute *attr, char *buf)			\
 {									\
 	struct ocp_device *odev = to_ocp_dev(dev);			\
 	type *add = odev->def->additions;				\


------=_Part_296_738199.1116326699774--
