Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285738AbRLHBp3>; Fri, 7 Dec 2001 20:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285739AbRLHBpN>; Fri, 7 Dec 2001 20:45:13 -0500
Received: from rj.sgi.com ([204.94.215.100]:49388 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S285738AbRLHBoy>;
	Fri, 7 Dec 2001 20:44:54 -0500
Date: Fri, 7 Dec 2001 17:44:49 -0800 (PST)
From: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
To: wolvie_cobain <wolvie@punkass.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH]Re: bug??
In-Reply-To: <Pine.LNX.4.33.0112072224200.8331-100000@caern.wolves.com.br>
Message-ID: <Pine.LNX.4.33.0112071743240.27423-100000@dbear.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to apply this. I hope this helps.

--- linux-2.5.1-pre6/fs/intermezzo/psdev.c	Sun Nov 11 10:20:21 2001
+++ work-linux-2.5.1-pre6/fs/intermezzo/psdev.c	Fri Dec  7 17:32:16 2001
@@ -46,6 +46,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <asm/io.h>
+#include <asm/ioctls.h>
 #include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/poll.h>





