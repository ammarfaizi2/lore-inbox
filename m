Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317360AbSGJE2p>; Wed, 10 Jul 2002 00:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSGJE2o>; Wed, 10 Jul 2002 00:28:44 -0400
Received: from draco.netpower.no ([212.33.133.34]:38930 "EHLO
	draco.netpower.no") by vger.kernel.org with ESMTP
	id <S317360AbSGJE2n>; Wed, 10 Jul 2002 00:28:43 -0400
Date: Wed, 10 Jul 2002 06:31:19 +0200
From: Erlend Aasland <erlend-a@innova.no>
To: Jaroslav Kysela <perex@suse.cz>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] sound/isa/ad1848/ad1848_lib.c need to #include <linux/init.h>
Message-ID: <20020710063119.B23535@innova.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The file sound/isa/ad1848/ad1848_lib.c seems to need <linux/init.h> in order to compile.


Erlend Aasland

--- linux-2.5.25/sound/isa/ad1848/ad1848_lib.c	2002-07-06 01:42:22.000000000 +0200
+++ linux-2.5.25-dirty/sound/isa/ad1848/ad1848_lib.c	2002-07-10 04:50:20.000000000 +0200
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <sound/core.h>
