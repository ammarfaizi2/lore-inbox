Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVEQKlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVEQKlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 06:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVEQKlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 06:41:36 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:64560 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261360AbVEQKk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:40:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=DP3oPi84H71pOlMvJ1F8qy7VnPe7hGT4jGi26HM1s4Z7fLLapVNYQ2SBAEUJKEbZUMwYQ2rQwF3Wbfo0lucvefWxWJGsIiUASbvI0gT1JGCSIi2O2fDFsZLmVvFey/9qR1p1K4FF86yS7wJSh8gdCQHKoDSUcxe6s7yRneDgooA=
Message-ID: <2538186705051703406a12b66f@mail.gmail.com>
Date: Tue, 17 May 2005 06:40:28 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: [PATCH 2.6.12-rc4 3/15] Documentation: update device attribute callbacks
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_256_4622879.1116326428954"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_256_4622879.1116326428954
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The following 11 patches update all the device_attribute callback
functions in the kernel to reflect the new function signatures. The
patches were mainly automatically generated with scripts nearly
identical to the previously submitted ones.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---

------=_Part_256_4622879.1116326428954
Content-Type: text/plain; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-Documentation.diff.diffstat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-Documentation.diff.diffstat.txt"

 sysfs.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)




------=_Part_256_4622879.1116326428954
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-Documentation.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-Documentation.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4-sysfsdyncallback-deviceattr/Documentation/filesystems/sysfs.txt linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/Documentation/filesystems/sysfs.txt
--- linux-2.6.12-rc4-sysfsdyncallback-deviceattr/Documentation/filesystems/sysfs.txt	2005-05-16 20:36:09.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update/Documentation/filesystems/sysfs.txt	2005-05-16 23:45:52.000000000 -0400
@@ -214,7 +214,7 @@ Other notes:
 
 A very simple (and naive) implementation of a device attribute is:
 
-static ssize_t show_name(struct device * dev, char * buf)
+static ssize_t show_name(struct device * dev, struct device_attribute *attr, char * buf)
 {
         return sprintf(buf,"%s\n",dev->name);
 }




------=_Part_256_4622879.1116326428954--
