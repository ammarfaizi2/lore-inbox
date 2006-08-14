Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWHNTfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWHNTfF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWHNTfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:35:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:46860 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751568AbWHNTfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:35:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PMln3akK9e1fpmMqs3oB3Y8XdFZwQaQ/FxGjK81V69yzmBpVHelpTn/PlRk/ZFJVa+jnzQavyB5Wjg0xSx0DypEXGP+rME/SDx8Fsl7zbH80El6nH77qvgD2HVjz+gAkkOPd52D8HO3K5lhdL0lDkDejviPhobx1Oq9Kk0wd2sE=
Message-ID: <44E0D085.8040507@gmail.com>
Date: Mon, 14 Aug 2006 21:35:33 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       "Antonino A. Daplas" <adaplas@pol.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 7/10] drivers/video/sis/sis_main.c Removal of old
 code
References: <44DE05FC.2090001@gmail.com> <44DE09A9.1030209@gmail.com>
In-Reply-To: <44DE09A9.1030209@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an upgrade to the previous patch.

(drivers-video-sis-sis_mainc-removal-of-old.patch)

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-mm/Documentation/dontdiff linux-mm-clean/drivers/video/sis/sis_main.c linux-mm/drivers/video/sis/sis_main.c
--- linux-mm-clean/drivers/video/sis/sis_main.c	2006-08-14 21:10:06.000000000 +0200
+++ linux-mm/drivers/video/sis/sis_main.c	2006-08-13 18:58:49.000000000 +0200
@@ -83,13 +83,7 @@ sisfb_setdefaultparms(void)
 	sisfb_max		= -1;
 	sisfb_userom		= -1;
 	sisfb_useoem		= -1;
-#ifdef MODULE
-	/* Module: "None" for 2.4, default mode for 2.5+ */
-	sisfb_mode_idx		= -1;
-#else
-	/* Static: Default mode */
 	sisfb_mode_idx		= -1;
-#endif
 	sisfb_parm_rate		= -1;
 	sisfb_crt1off		= 0;
 	sisfb_forcecrt1		= -1;

