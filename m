Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbUDFWET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUDFWET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:04:19 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:56581 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264047AbUDFWEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:04:13 -0400
Date: Wed, 7 Apr 2004 08:04:05 +1000
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Include init.h in pdaudiocf
Message-ID: <20040406220405.GA981@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch makes this file includes linux/init.h since it uses the __init
tag.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: sound/pcmcia/pdaudiocf/pdaudiocf.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/sound/pcmcia/pdaudiocf/pdaudiocf.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pdaudiocf.c
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c	5 Apr 2004 09:49:48 -0000	1.1.1.1
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c	6 Apr 2004 21:59:57 -0000
@@ -26,6 +26,7 @@
 #include <pcmcia/cisreg.h>
 #include "pdaudiocf.h"
 #include <sound/initval.h>
+#include <linux/init.h>
 
 /*
  */

--T4sUOijqQbZv57TR--
