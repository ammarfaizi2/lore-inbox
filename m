Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288889AbSANHX5>; Mon, 14 Jan 2002 02:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288882AbSANHXr>; Mon, 14 Jan 2002 02:23:47 -0500
Received: from marc1.theaimsgroup.com ([63.238.77.171]:56328 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S288864AbSANHXk>; Mon, 14 Jan 2002 02:23:40 -0500
Date: Mon, 14 Jan 2002 02:23:22 -0500
Message-Id: <200201140723.CAA11437@mailer.progressive-comp.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] tpyo in 2.2.20:include/linux/securebits.h
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tiny typo-fix for securebits.h (no idea if it's also present in 2.[45].x):

--- securebits.h.orig   Sun Mar 25 11:31:05 2001
+++ securebits.h        Mon Jan 14 02:16:17 2002
@@ -6,7 +6,7 @@
 extern unsigned securebits;
 
 /* When set UID 0 has no special privileges. When unset, we support
-   inheritance of root-permissions and suid-root executablew under
+   inheritance of root-permissions and suid-root executable under
    compatibility mode. We raise the effective and inheritable bitmasks
    *of the executable file* if the effective uid of the new process is
    0. If the real uid is 0, we raise the inheritable bitmask of the


--
Hank Leininger <hlein@progressive-comp.com> 
  
