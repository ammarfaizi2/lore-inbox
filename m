Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282199AbRKWS14>; Fri, 23 Nov 2001 13:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282200AbRKWS1g>; Fri, 23 Nov 2001 13:27:36 -0500
Received: from [206.196.53.54] ([206.196.53.54]:32480 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282199AbRKWS12>;
	Fri, 23 Nov 2001 13:27:28 -0500
Date: Fri, 23 Nov 2001 12:29:18 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Tim Tassonis <timtas@cubic.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.15-greased-turkey ???
In-Reply-To: <Pine.LNX.4.33.0111230953240.1294-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0111231220590.6347-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, Linus Torvalds wrote:

> It'sa worthy follow-up to the 2.2.x "greased weasel" releases, but as
> yesterday was Thanksgiving here in the US, and a lot of turkeys offered
> their lives in celebration of the new 2.5.0 tree, the 2.4.x series got
> christened a "greased turkey" instead of a weasel.

I had to apply the following patch before I could run this on my system:

--- Makefile~	Thu Nov 22 13:22:58 2001
+++ Makefile	Fri Nov 23 11:53:46 2001
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 15
-EXTRAVERSION =-greased-turkey
+EXTRAVERSION =-greased-tofurkey

 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

