Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTJWRFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 13:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTJWRFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 13:05:21 -0400
Received: from smtp2.fre.skanova.net ([195.67.227.95]:54470 "EHLO
	smtp2.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263637AbTJWRFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 13:05:11 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre8
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
From: Peter Osterlund <petero2@telia.com>
Date: 23 Oct 2003 19:05:00 +0200
In-Reply-To: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
Message-ID: <m23cdjopfn.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The toplevel Makefile contains this change which looks like a typo:

@@ -28,7 +28,7 @@
 AS             = $(CROSS_COMPILE)as
 LD             = $(CROSS_COMPILE)ld
 CC             = $(CROSS_COMPILE)gcc
-CPP            = $(CC) -E
+PP             = $(CC) -E
 AR             = $(CROSS_COMPILE)ar
 NM             = $(CROSS_COMPILE)nm
 STRIP          = $(CROSS_COMPILE)strip

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
