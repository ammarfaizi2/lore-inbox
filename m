Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264276AbUFCU5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUFCU5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUFCU5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:57:40 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:32450 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264276AbUFCU5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:57:39 -0400
To: geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Typo in Documentation/fb/framebuffer.txt
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 03 Jun 2004 22:57:58 +0200
Message-ID: <87zn7k4aw9.fsf@p4.48ers.dk>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Vertical retrace is in lines, not pixels.

--- Documentation/fb/framebuffer.txt.orig       2004-06-03 22:43:06.000000000 +0200
+++ Documentation/fb/framebuffer.txt    2004-06-03 22:43:50.000000000 +0200
@@ -190,7 +190,7 @@ We'll say that the horizontal scanrate i
     1/(32.141E-6 s) = 31.113E3 Hz
 
 A full screen counts 480 (yres) lines, but we have to consider the vertical
-retrace too (e.g. 49 `pixels'). So a full screen will take
+retrace too (e.g. 49 `lines'). So a full screen will take
 
     (480+49)*32.141E-6 s = 17.002E-3 s

-- 
Bye, Peter Korsgaard
