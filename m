Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271082AbTHLUQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271090AbTHLUQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:16:41 -0400
Received: from smtp03.web.de ([217.72.192.158]:23051 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S271082AbTHLUQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:16:40 -0400
Message-ID: <3F394B26.6060005@web.de>
Date: Tue, 12 Aug 2003 22:16:38 +0200
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-testX + mmX] PATCH small nls Makefile fix
Content-Type: multipart/mixed;
 boundary="------------060707050100000303030104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060707050100000303030104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

a small typo in the Makefile in fs/nls/ prevents codepage 1250 from 
compiling and installing whatever the .config value.

Best regards,
T.Todorov


--------------060707050100000303030104
Content-Type: text/plain;
 name="patch.cp1250"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.cp1250"

--- linux-2.6.0-test3-mm1/fs/nls/Makefile.orig	2003-08-10 12:46:30.000000000 +0200
+++ linux-2.6.0-test3-mm1/fs/nls/Makefile	2003-08-10 12:48:05.000000000 +0200
@@ -24,6 +24,7 @@
 obj-$(CONFIG_NLS_CODEPAGE_936)	+= nls_cp936.o nls_gb2312.o
 obj-$(CONFIG_NLS_CODEPAGE_949)	+= nls_cp949.o nls_euc-kr.o
 obj-$(CONFIG_NLS_CODEPAGE_950)	+= nls_cp950.o nls_big5.o
+obj-$(CONFIG_NLS_CODEPAGE_1250) += nls_cp1250.o
 obj-$(CONFIG_NLS_CODEPAGE_1251)	+= nls_cp1251.o
 obj-$(CONFIG_NLS_CODEPAGE_1255)	+= nls_cp1255.o
 obj-$(CONFIG_NLS_ISO8859_1)	+= nls_iso8859-1.o


--------------060707050100000303030104--

