Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVFBFr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVFBFr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 01:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVFBFr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 01:47:58 -0400
Received: from c-24-10-129-155.hsd1.ut.comcast.net ([24.10.129.155]:53704 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S261579AbVFBFrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 01:47:49 -0400
Date: Wed, 1 Jun 2005 23:48:52 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] eCryptfs: export key type
Message-ID: <20050602054852.GB4514@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the second in a series of three patches for the eCryptfs kernel
module.

The key_type_user symbol in user_defined.c needs to be exported.

-- 
Phillip Hellewell <phillip AT hellewell.homeip.net>

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.12-rc4-mm2-ecryptfs-2_of_3-export-key-type.diff"

diff -Naur linux-2.6.12-rc4-mm2/security/keys/user_defined.c linux-2.6.12-rc4-mm2-ecryptfs/security/keys/user_defined.c
--- linux-2.6.12-rc4-mm2/security/keys/user_defined.c	2005-05-23 21:20:38.252134304 -0600
+++ linux-2.6.12-rc4-mm2-ecryptfs/security/keys/user_defined.c	2005-05-23 21:38:04.092142456 -0600
@@ -48,6 +48,8 @@
 	char		data[0];	/* actual data */
 };
 
+EXPORT_SYMBOL( key_type_user );
+
 /*****************************************************************************/
 /*
  * instantiate a user defined key

--OgqxwSJOaUobr8KG--
