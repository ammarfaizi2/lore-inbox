Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRJPPFA>; Tue, 16 Oct 2001 11:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRJPPEl>; Tue, 16 Oct 2001 11:04:41 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:61923 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S276344AbRJPPEd>;
	Tue, 16 Oct 2001 11:04:33 -0400
To: fdavis@si.rr.com
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.4.12-ac1: a few more net MODULE_LICENSE patches
In-Reply-To: <3BC9C18C.6060808@si.rr.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 16 Oct 2001 17:05:00 +0200
In-Reply-To: Frank Davis's message of "Sun, 14 Oct 2001 12:47:08 -0400"
Message-ID: <d31yk31v8j.fsf@lxplus050.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Frank" == Frank Davis <fdavis@si.rr.com> writes:

Frank> Hello, I've attached a few more MODULE_LICENSE patches against
Frank> 2.4.12-ac1 .  A few more net MODULE_LICENSE patches to follow
Frank> soon. Please review.  Regards, Frank ---

ARGH!

Alan, please do not apply this one.

Why are you trying to remove my compat macro for MODULE_LICENSE? I am
trying to maintain the source so it compiles under multiple kernels!

If you submit acenic patches, make sure to drop a copy in my
inbox. Yes, I am listed in the source code, it's really hard to miss.

Jes

--- drivers/net/acenic.c.old	Fri Oct 12 18:42:54 2001
+++ drivers/net/acenic.c	Sun Oct 14 11:56:31 2001
@@ -145,10 +145,6 @@
 #endif
 
 
-#ifndef MODULE_LICENSE
-#define MODULE_LICENSE(a)
-#endif
-
 #ifndef wmb
 #define wmb()	mb()
 #endif
