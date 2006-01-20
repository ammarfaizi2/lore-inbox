Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWATXOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWATXOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWATXOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:14:21 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:56899 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751182AbWATXOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:14:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=CVlGBQ7EWVZlLSFN1+GD5f/0/nRyXUxWdUDKHq6L/fQ1RMEGMAbgmdnNb5+dX3fWWsGHD8qwLDJZ1sIaq0v+SxaRsPvw1ApkDxqP2DdnJD2ngXis5iKq5sHD1oQic4fDFCcIxj4iAPmuy4yCZUEjd5jzLv3dKFRavsqNCPEg5pY=
Date: Sat, 21 Jan 2006 02:31:18 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxsh-shmedia-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/sh64/kernel/time.c: add module.h
Message-ID: <20060120233118.GB3511@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It uses EXPORT_SYMBOL.

arch/sh64/kernel/time.c:254: warning: type defaults to `int' in declaration of `EXPORT_SYMBOL'
arch/sh64/kernel/time.c:254: warning: parameter names (without types) in function declaration
arch/sh64/kernel/time.c:254: warning: data definition has no type or storage class

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/sh64/kernel/time.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/sh64/kernel/time.c
+++ b/arch/sh64/kernel/time.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/profile.h>
 #include <linux/smp.h>
+#include <linux/module.h>
 
 #include <asm/registers.h>	 /* required by inline __asm__ stmt. */
 

