Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423079AbWJVGjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423079AbWJVGjd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 02:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423084AbWJVGjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 02:39:33 -0400
Received: from smtp104.plus.mail.re2.yahoo.com ([206.190.53.29]:43663 "HELO
	smtp104.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1423079AbWJVGjb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 02:39:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:Content-Disposition:User-Agent:Content-Transfer-Encoding;
  b=MCkCBoSoF4Ry6cwUgQUzzDVM4WdVSOPEkW5m9YdN65TErQCvK8VgxjV5lONvFaJOpEg9b1k3HgDAheURQ3CbJFy+csGIe+ZYMRy28KkYoqIaMcCBzPmXkQpdcn9aisp/F2ynZocuNr0NNVYpHjti5aPaO3K4AJ82oMgc99tWtK4=  ;
Date: Sun, 22 Oct 2006 08:39:24 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] do not compile Sony Vaio extras as a module per default
Message-ID: <20061022063924.GA7177@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: <petkov@math.uni-muenster.de>

--- current/drivers/acpi/Kconfig.orig	2006-10-21 10:02:23.000000000 +0200
+++ current/drivers/acpi/Kconfig	2006-10-21 10:02:30.000000000 +0200
@@ -262,7 +262,6 @@ config ACPI_SONY
 	tristate "Sony Laptop Extras"
 	depends on X86 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
-	default m
 	  ---help---
 	  This mini-driver drives the ACPI SNC device present in the
 	  ACPI BIOS of the Sony Vaio laptops.

-- 
Regards/Gruß,
    Boris.

	

	
		
___________________________________________________________ 
Der frühe Vogel fängt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de
