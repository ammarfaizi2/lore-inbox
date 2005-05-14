Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVENJZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVENJZV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 05:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVENJZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 05:25:20 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:39143 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261182AbVENJZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 05:25:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=B4H6wJhlsUpRhKWq3yb74TbKVo3BUWB9U+aVtRAFe/1dIjSNVLWOMcj20WgVMVA2ghs2dHnn+u9OuBKErl8goBO3klVAL523tryoXrDGFEXeIQAcyezmrLTegnEsDRzOMJ+XIr4Vh7O+wKWp2T+QXlApmcgWvvIVcPIndM+hivg=
Message-ID: <253818670505140225603b967f@mail.gmail.com>
Date: Sat, 14 May 2005 05:25:11 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 2/12] Documentation: (dynamic sysfs callbacks) update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1403_13179478.1116062711807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1403_13179478.1116062711807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_1403_13179478.1116062711807
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-Documentation.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-Documentation.diff.diffstat.txt"

 sysfs.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)



------=_Part_1403_13179478.1116062711807
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-Documentation.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff-Documentation.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/Documentation/filesystems/sysfs.txt linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/Documentation/filesystems/sysfs.txt
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/Documentation/filesystems/sysfs.txt	2005-05-11 00:28:12.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn/Documentation/filesystems/sysfs.txt	2005-05-11 00:34:03.000000000 -0400
@@ -214,7 +214,7 @@ Other notes:
 
 A very simple (and naive) implementation of a device attribute is:
 
-static ssize_t show_name(struct device * dev, char * buf)
+static ssize_t show_name(struct device * dev, char * buf, void *private)
 {
         return sprintf(buf,"%s\n",dev->name);
 }



------=_Part_1403_13179478.1116062711807--
