Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVC2Ugm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVC2Ugm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVC2Ugl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:36:41 -0500
Received: from smtp16.wxs.nl ([195.121.6.39]:36325 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S261369AbVC2Ug2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:36:28 -0500
Date: Tue, 29 Mar 2005 22:36:24 +0200
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH] embarassing typo
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-id: <1112128584.25954.6.camel@tux.lan>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: multipart/mixed; boundary="Boundary_(ID_bXmPGALhbkKnQ5vz+kzClg)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_bXmPGALhbkKnQ5vz+kzClg)
Content-type: text/plain
Content-transfer-encoding: 7BIT

Hi Andrew,

for some unknown reason, I suddenly found the attached typo. It doesn't
cause anything bad (at least not on my computer according to some
tests), but is still very much so embarassing, so please apply to the
kernel tree. Who knows, maybe it fixes some obscure unfixeable bug for
some people.

Signed-off-by: Ronald S. Bultje <rbultje@ronald.bitfreak.net>

Thanks,

Ronald

-- 
Ronald S. Bultje <rbultje@ronald.bitfreak.net>

--Boundary_(ID_bXmPGALhbkKnQ5vz+kzClg)
Content-type: text/plain; name=x; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=x

? .tmp_versions
Index: zr36050.c
===================================================================
RCS file: /cvsroot/mjpeg/driver-zoran/zr36050.c,v
retrieving revision 1.2
diff -u -r1.2 zr36050.c
--- linux-2.6.5/drivers/media/video/zr36050.c.old	16 Sep 2004 22:53:27 -0000	1.2
+++ linux-2.6.5/drivers/media/video/zr36050.c	29 Mar 2005 20:30:23 -0000
@@ -419,7 +419,7 @@
 	dri_data[2] = 0x00;
 	dri_data[3] = 0x04;
 	dri_data[4] = ptr->dri >> 8;
-	dri_data[5] = ptr->dri * 0xff;
+	dri_data[5] = ptr->dri & 0xff;
 	return zr36050_pushit(ptr, ZR050_DRI_IDX, 6, dri_data);
 }
 

--Boundary_(ID_bXmPGALhbkKnQ5vz+kzClg)--
