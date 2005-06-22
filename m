Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVFVPfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVFVPfC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVFVPdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:33:16 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:30883 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261470AbVFVPaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:30:12 -0400
Message-ID: <42B983FF.4050804@brturbo.com.br>
Date: Wed, 22 Jun 2005 12:30:07 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH] V4L API new webcam formats included
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050900040701010603030502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050900040701010603030502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Add Philips Webcam format.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Luc Saillard <luc@saillard.org>.
Signed-off-by: Nickolay V Shmyrev <nshmyrev@yandex.ru>

 linux/include/linux/videodev2.h |    2 ++
 1 files changed, 2 insertions(+)


--------------050900040701010603030502
Content-Type: text/x-patch;
 name="v4l_patch03_v4l2_api.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_patch03_v4l2_api.patch"

diff -u linux-2.6.12-mm1/include/linux/videodev2.h linux/include/linux/videodev2.h
--- linux-2.6.12-mm1/include/linux/videodev2.h	2005-06-17 16:48:29.000000000 -0300
+++ linux/include/linux/videodev2.h	2005-06-22 01:29:48.000000000 -0300
@@ -221,6 +221,8 @@
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_WNVA     v4l2_fourcc('W','N','V','A') /* Winnov hw compress */
 #define V4L2_PIX_FMT_SN9C10X  v4l2_fourcc('S','9','1','0') /* SN9C10x compression */
+#define V4L2_PIX_FMT_PWC1     v4l2_fourcc('P','W','C','1') /* pwc older webcam */
+#define V4L2_PIX_FMT_PWC2     v4l2_fourcc('P','W','C','2') /* pwc newer webcam */
 
 /*
  *	F O R M A T   E N U M E R A T I O N

--------------050900040701010603030502--
