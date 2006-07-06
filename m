Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWGFVxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWGFVxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWGFVxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:53:40 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:31902
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750837AbWGFVxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:53:40 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Miniconfig revisited (0/3)
Date: Thu, 6 Jul 2006 17:53:43 -0400
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607061753.43518.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's a rewrite of the mini.config patch that's just a makefile tweak to 
add the "make miniconfig" target, the miniconfig generator script, and some 
documentation.  No C code is touched by this patch series.

At some point I'd like to replace the guts of scripts/shrinkconfig with 
internal changes to kconfig that spit out a mini.config directly.  The script 
shrinks the current defconfig from 1584 lines to 116, but it takes 28 minutes 
to do so on my laptop.  However, in the past six months I haven't gotten 
around to tackling that and it won't creep up my to-do list sitting 
unsubmitted on my hard drive, so...

Rob
-- 
Never bet against the cheap plastic solution.
