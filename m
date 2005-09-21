Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVIUQrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVIUQrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVIUQrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:47:07 -0400
Received: from [151.97.230.9] ([151.97.230.9]:31630 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751125AbVIUQrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:47:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 08/10] uml: readd removed unistd.h inclusion
Date: Wed, 21 Sep 2005 18:40:10 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921164010.30500.40577.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Readd this header (deleted in 60d339f6fe0831060600c62418b71a62ad26c281). A
warning is spit out here about undeclared getpgrp().

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/process.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
 #include <signal.h>

