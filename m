Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTLJVSF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTLJVSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:18:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:61587 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264104AbTLJVSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:18:01 -0500
Date: Wed, 10 Dec 2003 22:17:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Maciej Zenczykowski <maze@cela.pl>,
       David Schwartz <davids@webmaster.com>,
       Jason Kingsland <Jason_Kingsland@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.10.10312101300030.3805-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.58.0312102212370.1125@earth>
References: <Pine.LNX.4.10.10312101300030.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Dec 2003, Andre Hedrick wrote:

> I have and the lawyers tell me that it is one or the other and can not
> be both.  So explain to me how a GPL/BSD or BSD/GPL works again?

ugh. Are your lawyers saying that the tons of dual-licensed code is not a
valid license? Seems like your lawyers disagree with lots of other
lawyers.

> Also if one does an md5sum on the "COPYING" file from FSF and compares
> it from the one in the kernel source they differ.

here's the (trivial) diff. Draw your own conclusions.

--- libc/COPYING	2001-07-06 07:57:07.000000000 +0200
+++ v/COPYING	2003-11-23 13:21:58.000000000 +0100
@@ -1,3 +1,19 @@
+
+   NOTE! This copyright does *not* cover user programs that use kernel
+ services by normal system calls - this is merely considered normal use
+ of the kernel, and does *not* fall under the heading of "derived work".
+ Also note that the GPL below is copyrighted by the Free Software
+ Foundation, but the instance of code that it refers to (the Linux
+ kernel) is copyrighted by me and others who actually wrote it.
+
+ Also note that the only valid version of the GPL as far as the kernel
+ is concerned is _this_ particular version of the license (ie v2, not
+ v2.2 or v3.x or whatever), unless explicitly otherwise stated.
+
+			Linus Torvalds
+
+----------------------------------------
+
 		    GNU GENERAL PUBLIC LICENSE
 		       Version 2, June 1991
 
