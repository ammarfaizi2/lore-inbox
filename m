Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282198AbRK1Xsx>; Wed, 28 Nov 2001 18:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282199AbRK1Xsn>; Wed, 28 Nov 2001 18:48:43 -0500
Received: from zero.tech9.net ([209.61.188.187]:47370 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282198AbRK1Xs2>;
	Wed, 28 Nov 2001 18:48:28 -0500
Subject: Re: Linux 2.4.17-pre1
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
In-Reply-To: <E169EIY-0006UI-00@the-village.bc.nu>
In-Reply-To: <E169EIY-0006UI-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 18:48:13 -0500
Message-Id: <1006991294.813.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-28 at 18:39, Alan Cox wrote:
> > use "BSD without advertising clause", which causes the kernel to be
> > tainted. Shouldn't fs/nls/*.c use "Dual BSD/GPL" or "GPL" instead?
> 
> Dual BSD/GPL is the correct one.  Not a big issue. Since the GPL allows
> stuff to be freer than GPL but still GPL its arguably correct too I
> suspect

I was waiting for confirmation about the license status...without
getting into what license is correct and legal, the current
MODULE_LICENSE value taints the kernel.  The attached patch switches to
Dual BSD/GPL.

Marcelo, please apply.

	Robert Love

diff -urN linux-2.4.17-pre1/fs/nls/nls_cp1251.c linux/fs/nls/nls_cp1251.c
--- linux-2.4.17-pre1/fs/nls/nls_cp1251.c	Wed Nov 28 15:15:10 2001
+++ linux/fs/nls/nls_cp1251.c	Wed Nov 28 18:41:14 2001
@@ -315,4 +315,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp1255.c linux/fs/nls/nls_cp1255.c
--- linux-2.4.17-pre1/fs/nls/nls_cp1255.c	Wed Nov 28 15:15:10 2001
+++ linux/fs/nls/nls_cp1255.c	Wed Nov 28 18:41:29 2001
@@ -396,4 +396,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp437.c linux/fs/nls/nls_cp437.c
--- linux-2.4.17-pre1/fs/nls/nls_cp437.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp437.c	Wed Nov 28 18:41:40 2001
@@ -401,4 +401,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp737.c linux/fs/nls/nls_cp737.c
--- linux-2.4.17-pre1/fs/nls/nls_cp737.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp737.c	Wed Nov 28 18:41:50 2001
@@ -364,4 +364,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp775.c linux/fs/nls/nls_cp775.c
--- linux-2.4.17-pre1/fs/nls/nls_cp775.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp775.c	Wed Nov 28 18:42:00 2001
@@ -333,4 +333,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp850.c linux/fs/nls/nls_cp850.c
--- linux-2.4.17-pre1/fs/nls/nls_cp850.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp850.c	Wed Nov 28 18:42:10 2001
@@ -329,4 +329,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp852.c linux/fs/nls/nls_cp852.c
--- linux-2.4.17-pre1/fs/nls/nls_cp852.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp852.c	Wed Nov 28 18:42:22 2001
@@ -351,4 +351,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp855.c linux/fs/nls/nls_cp855.c
--- linux-2.4.17-pre1/fs/nls/nls_cp855.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp855.c	Wed Nov 28 18:42:34 2001
@@ -313,4 +313,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp857.c linux/fs/nls/nls_cp857.c
--- linux-2.4.17-pre1/fs/nls/nls_cp857.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp857.c	Wed Nov 28 18:43:07 2001
@@ -315,4 +315,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp860.c linux/fs/nls/nls_cp860.c
--- linux-2.4.17-pre1/fs/nls/nls_cp860.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp860.c	Wed Nov 28 18:45:14 2001
@@ -378,4 +378,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp861.c linux/fs/nls/nls_cp861.c
--- linux-2.4.17-pre1/fs/nls/nls_cp861.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp861.c	Wed Nov 28 18:43:42 2001
@@ -401,4 +401,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp862.c linux/fs/nls/nls_cp862.c
--- linux-2.4.17-pre1/fs/nls/nls_cp862.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp862.c	Wed Nov 28 18:43:50 2001
@@ -435,4 +435,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp863.c linux/fs/nls/nls_cp863.c
--- linux-2.4.17-pre1/fs/nls/nls_cp863.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp863.c	Wed Nov 28 18:43:59 2001
@@ -395,4 +395,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp864.c linux/fs/nls/nls_cp864.c
--- linux-2.4.17-pre1/fs/nls/nls_cp864.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp864.c	Wed Nov 28 18:44:07 2001
@@ -421,4 +421,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp865.c linux/fs/nls/nls_cp865.c
--- linux-2.4.17-pre1/fs/nls/nls_cp865.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp865.c	Wed Nov 28 18:44:16 2001
@@ -401,4 +401,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp866.c linux/fs/nls/nls_cp866.c
--- linux-2.4.17-pre1/fs/nls/nls_cp866.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp866.c	Wed Nov 28 18:44:36 2001
@@ -319,4 +319,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp869.c linux/fs/nls/nls_cp869.c
--- linux-2.4.17-pre1/fs/nls/nls_cp869.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp869.c	Wed Nov 28 18:44:43 2001
@@ -329,4 +329,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");
diff -urN linux-2.4.17-pre1/fs/nls/nls_cp874.c linux/fs/nls/nls_cp874.c
--- linux-2.4.17-pre1/fs/nls/nls_cp874.c	Wed Nov 28 15:15:09 2001
+++ linux/fs/nls/nls_cp874.c	Wed Nov 28 18:44:51 2001
@@ -287,4 +287,4 @@
  * c-continued-brace-offset: 0
  * End:
  */
-MODULE_LICENSE("BSD without advertising clause");
+MODULE_LICENSE("Dual BSD/GPL");

