Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVIZUil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVIZUil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVIZUik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:38:40 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:16573 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750701AbVIZUik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:38:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=emuLPuhpzWClK9KkekpIgpugPQCGxl5Y2n0UpzPKkXqOxllh/zvcj2whbqnHQWKjlXrsZOAxukeaxhcwXBpfY2bGi5TnYNC2N6GDlnQyuU1uHVh6oJtyAeXcgDt14yRMJedwynhdJgAN0KZ0C7D/D+/mLB4macaUVLzFVC5dqOk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] *tiny* CodingStyle correction
Date: Mon, 26 Sep 2005 22:40:53 +0200
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509262240.53212.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CodingStyle is supposed to set a good example, so 
  int fun(int )
doesn't look too good ;-)

I considered both
  int fun(void)
and
  int fun(int a)
as replacements, and settled on the last.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/CodingStyle |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14-rc2-git3-orig/Documentation/CodingStyle	2005-09-22 00:27:53.000000000 +0200
+++ linux-2.6.14-rc2-git3/Documentation/CodingStyle	2005-09-26 22:36:37.000000000 +0200
@@ -199,7 +199,7 @@
     modifications are prevented
 - saves the compiler work to optimize redundant code away ;)
 
-int fun(int )
+int fun(int a)
 {
 	int result = 0;
 	char *buffer = kmalloc(SIZE);


