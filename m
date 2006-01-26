Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWAZW5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWAZW5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWAZW5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:57:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7175 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030185AbWAZW5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:57:37 -0500
Date: Thu, 26 Jan 2006 23:57:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [9/10] remove ISA legacy functions: remove documentation
Message-ID: <20060126225736.GN3668@stusta.de>
References: <20060126223126.GD3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126223126.GD3668@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the documentation of the ISA legacy functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-mm2-full/Documentation/DocBook/deviceiobook.tmpl.old	2005-11-11 21:44:08.000000000 +0100
+++ linux-2.6.14-mm2-full/Documentation/DocBook/deviceiobook.tmpl	2005-11-11 21:44:18.000000000 +0100
@@ -270,25 +270,6 @@
       </para>
     </sect1>
 
-    <sect1>
-      <title>ISA legacy functions</title>
-      <para>
-	On older kernels (2.2 and earlier) the ISA bus could be read or
-	written with these functions and without ioremap being used. This is
-	no longer true in Linux 2.4. A set of equivalent functions exist for
-	easy legacy driver porting. The functions available are prefixed
-	with 'isa_' and are <function>isa_readb</function>,
-	<function>isa_writeb</function>, <function>isa_readw</function>, 
-	<function>isa_writew</function>, <function>isa_readl</function>,
-	<function>isa_writel</function>, <function>isa_memcpy_fromio</function>
-	and <function>isa_memcpy_toio</function>
-      </para>
-      <para>
-	These functions should not be used in new drivers, and will
-	eventually be going away.
-      </para>
-    </sect1>
-
   </chapter>
 
   <chapter>

