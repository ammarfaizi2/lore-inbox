Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTFCWHC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbTFCWHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:07:02 -0400
Received: from dsl-hkigw4a35.dial.inet.fi ([80.222.48.53]:23272 "EHLO
	dsl-hkigw4a35.dial.inet.fi") by vger.kernel.org with ESMTP
	id S261450AbTFCWHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:07:01 -0400
Date: Wed, 4 Jun 2003 01:20:39 +0300 (EEST)
From: Petri Koistinen <petri.koistinen@iki.fi>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.4] update README file to current realities
Message-ID: <Pine.LNX.4.56.0306040104180.18774@dsl-hkigw4a35.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Similar little clarification patch got accepted in 2.5.63 and I think this
could be helpful in 2.4.x kernel tree too.

Best regards,
Petri Koistinen

--- linux-2.4/README.orig	2003-06-04 00:52:33.000000000 +0300
+++ linux-2.4/README	2003-06-04 00:54:42.000000000 +0300
@@ -64,12 +64,12 @@
  - You can also upgrade between 2.4.xx releases by patching.  Patches are
    distributed in the traditional gzip and the new bzip2 format.  To
    install by patching, get all the newer patch files, enter the
-   directory in which you unpacked the kernel source and execute:
+   top level directory of the kernel source (linux-2.4.xx) and execute:

-		gzip -cd patchXX.gz | patch -p0
+               gzip -cd ../patch-2.4.xx.gz | patch -p1

    or
-		bzip2 -dc patchXX.bz2 | patch -p0
+               bzip2 -dc ../patch-2.4.xx.bz2 | patch -p1

    (repeat xx for all versions bigger than the version of your current
    source tree, _in_order_) and you should be ok.  You may want to remove
