Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbTJWPW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbTJWPW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:22:29 -0400
Received: from APlessis-Bouchard-112-1-6-202.w81-51.abo.wanadoo.fr ([81.51.226.202]:5799
	"EHLO fozzy.syrius.org") by vger.kernel.org with ESMTP
	id S263601AbTJWPW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:22:27 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre8
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
From: laurent.ml@linuxfr.org
Date: Thu, 23 Oct 2003 17:22:24 +0200
In-Reply-To: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet> (Marcelo
 Tosatti's message of "Wed, 22 Oct 2003 21:24:17 -0200 (BRST)")
Message-ID: <wazza.87ad7sf07j.fsf@message.id>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

>   o [IRDA]: Fix build with gcc-3.4

Tell me if I'm wrong, it seems 2 comas are missing.


--=-=-=
Content-Disposition: attachment; filename=irda.2.4.23-pre8.diff

diff -ur linux-2.4.23-pre8.orig/net/irda/af_irda.c linux-2.4.23-pre8/net/irda/af_irda.c
--- linux-2.4.23-pre8.orig/net/irda/af_irda.c	2003-10-23 17:11:55.000000000 +0200
+++ linux-2.4.23-pre8/net/irda/af_irda.c	2003-10-23 16:38:34.000000000 +0200
@@ -285,7 +285,7 @@
 		self->max_data_size = irttp_get_max_seg_size(self->tsap);
 	};
 
-	IRDA_DEBUG(2, "%s(), max_data_size=%d\n", __FUNCTION__
+	IRDA_DEBUG(2, "%s(), max_data_size=%d\n", __FUNCTION__,
 		   self->max_data_size);
 
 	memcpy(&self->qos_tx, qos, sizeof(struct qos_info));
@@ -384,7 +384,7 @@
 
 	/* Check if request succeeded */
 	if (result != IAS_SUCCESS) {
-		IRDA_DEBUG(1, "%s(), IAS query failed! (%d)\n", __FUNCTION__
+		IRDA_DEBUG(1, "%s(), IAS query failed! (%d)\n", __FUNCTION__,
 			   result);
 
 		self->errno = result;	/* We really need it later */

--=-=-=


-- 
Laurent

--=-=-=--
