Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135948AbRDTPvM>; Fri, 20 Apr 2001 11:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135949AbRDTPvD>; Fri, 20 Apr 2001 11:51:03 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:20166 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S135948AbRDTPuv>; Fri, 20 Apr 2001 11:50:51 -0400
Date: Fri, 20 Apr 2001 16:50:49 +0100
From: Tim Waugh <tim@cyberelk.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.4-pre5: deviceiobook.tmpl things
Message-ID: <20010420165049.A19504@cyberelk.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a typo in this file, and also include/asm-i386/io.h has no
extractable documentation.

Tim.
*/

--- linux/Documentation/DocBook/deviceiobook.tmpl.deviceio	Fri Apr 20 16:46:16 2001
+++ linux/Documentation/DocBook/deviceiobook.tmpl	Fri Apr 20 16:49:23 2001
@@ -171,7 +171,7 @@
 	with 'isa_' and are <function>isa_readb</function>,
 	<function>isa_writeb</function>, <function>isa_readw</function>, 
 	<function>isa_writew</function>, <function>isa_readl</function>,
-	<function>isa_writel</function), <function>isa_memcpy_fromio</function>
+	<function>isa_writel</function>, <function>isa_memcpy_fromio</function>
 	and <function>isa_memcpy_toio</function>
       </para>
       <para>
@@ -222,11 +222,6 @@
       </para>
     </sect1>
 
-  </chapter>
-
-  <chapter id="pubfunctions">
-     <title>Public Functions Provided</title>
-!Einclude/asm-i386/io.h
   </chapter>
 
 </book>
