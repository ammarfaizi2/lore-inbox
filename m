Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbULMNoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbULMNoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 08:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbULMNoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 08:44:38 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:400 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S262262AbULMNof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 08:44:35 -0500
Message-ID: <41BD9CCC.6010005@blue-labs.org>
Date: Mon, 13 Dec 2004 08:44:44 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Danny Beaudoin <beaudoin_danny@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Description should be updated
References: <BAY21-F31C2845A332866774C3A2CF3AB0@phx.gbl> <41BCEB0A.3060807@osdl.org>
In-Reply-To: <41BCEB0A.3060807@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070206070400060608080102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070206070400060608080102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Danny, attached is a patch you may like.

David

Randy.Dunlap wrote:

> Danny Beaudoin wrote:
>
>> Hi again!
>> In Device Drivers/Graphics Support/Console display driver support/VGA 
>> test console (NEW) 
>

--------------070206070400060608080102
Content-Type: text/x-patch;
 name="VGA_CONSOLE.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="VGA_CONSOLE.diff"

--- drivers/video/console/Kconfig~	2004-12-13 08:41:30.926219984 -0500
+++ drivers/video/console/Kconfig	2004-12-13 08:41:30.927219832 -0500
@@ -9,15 +9,15 @@
 	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC32 && !SPARC64 && !M68K && !PARISC
 	default y
 	help
-	  Saying Y here will allow you to use Linux in text mode through a
-	  display that complies with the generic VGA standard. Virtually
-	  everyone wants that.
+	  This is always enabled on X86 systems.  If your system is embedded
+	  or not X86 and you want to use Linux in text mode through a
+	  display that complies with the generic VGA standard, say Y here.
 
 	  The program SVGATextMode can be used to utilize SVGA video cards to
 	  their full potential in text mode. Download it from
 	  <ftp://ibiblio.org/pub/Linux/utils/console/>.
 
-	  Say Y.
+	  If unsure, say Y (default).
 
 #	if [ "$CONFIG_PCI" = "y" -a "$CONFIG_VGA_CONSOLE" = "y" ]; then
 #	   bool '   Allow VGA on any bus?' CONFIG_VGA_HOSE

--------------070206070400060608080102--
