Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317696AbSHLJWN>; Mon, 12 Aug 2002 05:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317712AbSHLJWN>; Mon, 12 Aug 2002 05:22:13 -0400
Received: from fep02.superonline.com ([212.252.122.41]:41185 "EHLO
	fep02.superonline.com") by vger.kernel.org with ESMTP
	id <S317696AbSHLJWK>; Mon, 12 Aug 2002 05:22:10 -0400
Message-ID: <3D577E30.9020100@superonline.com>
Date: Mon, 12 Aug 2002 12:21:52 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020807
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre1-ac2
Content-Type: multipart/mixed;
 boundary="------------040802090309040609050600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040802090309040609050600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I had to revert this change in speakup makefile
in order to compile.


--------------040802090309040609050600
Content-Type: text/plain;
 name="speakup-change_ac1-ac2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="speakup-change_ac1-ac2"

diff -u linux.20pre1-ac1/drivers/char/speakup/Makefile linux.20pre1-ac2/drivers/char/speakup/Makefile
--- linux.20pre1-ac1/drivers/char/speakup/Makefile	2002-08-06 15:42:07.000000000 +0100
+++ linux.20pre1-ac2/drivers/char/speakup/Makefile	2002-08-07 14:56:06.000000000 +0100
@@ -21,4 +21,5 @@
-include $(TOPDIR)/Rules.make
-
 speakupmap.c: speakupmap.map
 	set -e ; loadkeys --mktable $< | sed -e 's/^static *//' > $@
+
+include $(TOPDIR)/Rules.make
+

--------------040802090309040609050600--

