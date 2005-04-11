Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVDKUHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVDKUHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVDKUHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:07:37 -0400
Received: from mail.dif.dk ([193.138.115.101]:59588 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261911AbVDKUGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:06:31 -0400
Date: Mon, 11 Apr 2005 22:09:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] cifs: md5 header cleanup
Message-ID: <Pine.LNX.4.62.0504112207290.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conform to style of other fs/cifs/ files

Patch is also available from this URL:
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_md5-header.patch


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc2-mm2-orig/fs/cifs/md5.h	2005-03-02 08:37:47.000000000 +0100
+++ linux-2.6.12-rc2-mm2/fs/cifs/md5.h	2005-04-09 10:29:30.000000000 +0200
@@ -10,7 +10,7 @@ struct MD5Context {
 	__u32 bits[2];
 	unsigned char in[64];
 };
-#endif				/* !MD5_H */
+#endif	/* MD5_H */
 
 #ifndef _HMAC_MD5_H
 struct HMACMD5Context {
@@ -18,21 +18,21 @@ struct HMACMD5Context {
 	unsigned char k_ipad[65];
 	unsigned char k_opad[65];
 };
-#endif				/* _HMAC_MD5_H */
+#endif	/* _HMAC_MD5_H */
 
 void MD5Init(struct MD5Context *context);
 void MD5Update(struct MD5Context *context, unsigned char const *buf,
-			unsigned len);
+	unsigned len);
 void MD5Final(unsigned char digest[16], struct MD5Context *context);
 
 /* The following definitions come from lib/hmacmd5.c  */
 
 void hmac_md5_init_rfc2104(unsigned char *key, int key_len,
-			struct HMACMD5Context *ctx);
+	struct HMACMD5Context *ctx);
 void hmac_md5_init_limK_to_64(const unsigned char *key, int key_len,
-			struct HMACMD5Context *ctx);
+	struct HMACMD5Context *ctx);
 void hmac_md5_update(const unsigned char *text, int text_len,
-			struct HMACMD5Context *ctx);
+	struct HMACMD5Context *ctx);
 void hmac_md5_final(unsigned char *digest, struct HMACMD5Context *ctx);
 void hmac_md5(unsigned char key[16], unsigned char *data, int data_len,
-			unsigned char *digest);
+	unsigned char *digest);


