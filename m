Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbVGIA54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbVGIA54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbVGIAzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:55:53 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:64441 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263061AbVGIAxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:53:53 -0400
Message-ID: <42CF201B.5080804@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:53:47 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/14 2.6.13-rc2-mm1] V4L tuner-3026 - replace obsolete ioctl
 value
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------060902030807010304020300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060902030807010304020300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------060902030807010304020300
Content-Type: text/x-patch;
 name="v4l_tuner_3026.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_tuner_3026.diff"

- obsolete TUNER_SET_TVFREQ changed to VIDIOCSFREQ.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>


 linux-2.6.13-rc2-mm1/drivers/media/video/tuner-3036.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.13-rc2-mm1/drivers/media/video/tuner-3036.c.orig	2005-07-07 23:35:35.000000000 -0300
+++ linux-2.6.13-rc2-mm1/drivers/media/video/tuner-3036.c	2005-07-07 23:36:28.000000000 -0300
@@ -152,7 +152,7 @@ tuner_command(struct i2c_client *client,
 
 	switch (cmd) 
 	{
-		case TUNER_SET_TVFREQ:
+		case VIDIOCSFREQ:
 			set_tv_freq(client, *iarg);
 			break;
 	    

--------------060902030807010304020300--
