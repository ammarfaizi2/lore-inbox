Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbRFRAlk>; Sun, 17 Jun 2001 20:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263244AbRFRAla>; Sun, 17 Jun 2001 20:41:30 -0400
Received: from geos.coastside.net ([207.213.212.4]:28894 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S263228AbRFRAlQ>; Sun, 17 Jun 2001 20:41:16 -0400
Mime-Version: 1.0
Message-Id: <p05100306b752fe46f9a5@[207.213.214.37]>
In-Reply-To: <20010618023459.C1063@ivan.doma>
In-Reply-To: <20010618014547.B1063@ivan.doma>
 <Pine.LNX.4.33.0106180102520.25038-100000@infradead.org>
 <20010618023459.C1063@ivan.doma>
Date: Sun, 17 Jun 2001 17:41:01 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: any good diff merging utility?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:34 AM +0200 2001-06-18, Ivan Vadovic wrote:
>Very often the case is that they indeed can be merged automagically.
>For example two patches inserting few lines right after the #include
>lines.
>
>patch1:
>@@ 10,1 10,2 @@
>  #include <foo.h>
>+#include <1.h>
>
>patch2:
>@@ 10,1 10,2 @@
>  #include <foo.h>
>+#include <2.h>
>
>The patch will fail to patch :-). But there is no real conflict between
>the patches.

Problem is, you can't tell automatically. Even if the diffs don't 
conflict physically, it's entirely possible that they conflict 
logically.
-- 
/Jonathan Lundell.
