Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTEGWPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTEGWPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:15:55 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.36.230]:57285 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S264304AbTEGWPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:15:55 -0400
Date: Wed, 7 May 2003 16:11:25 -0500 (CDT)
From: Paul B Schroeder <paulsch@haywired.net>
To: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
cc: <girouard@us.ibm.com>
Subject: [PATCH 2.5] mwave compile fix
Message-ID: <Pine.LNX.4.33.0305071609270.28791-100000@snafu.haywired.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against 2.5.69..  Please apply...

diff -u drivers/char/mwave/mwavedd.h.orig drivers/char/mwave/mwavedd.h
--- drivers/char/mwave/mwavedd.h.orig   2003-05-07 17:04:33.000000000 -0500
+++ drivers/char/mwave/mwavedd.h        2003-05-07 17:04:22.000000000 -0500
@@ -50,6 +50,7 @@
 #define _LINUX_MWAVEDD_H
 #include "3780i.h"
 #include "tp3780i.h"
+#include "smapi.h"
 #include "mwavepub.h"
 #include <linux/ioctl.h>
 #include <asm/uaccess.h>


-- 

Paul B Schroeder <paulsch at haywired dot net>


