Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263082AbSJBMs0>; Wed, 2 Oct 2002 08:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263093AbSJBMs0>; Wed, 2 Oct 2002 08:48:26 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:32030 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S263082AbSJBMsZ>;
	Wed, 2 Oct 2002 08:48:25 -0400
Date: Wed, 2 Oct 2002 14:53:45 +0200 (CEST)
From: Witek Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Modular IDE screwed (2.5.38-2.5.40)
Message-ID: <Pine.LNX.4.44L.0210021449540.32740-100000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. init_module in drivers/ide/ide.c is defined twice (not compiling)
2. After removing second init_module definition, it is compiling but lots 
of unresolved symbols in all ide modules so it's not working at all.
Ide built-in in kernel is working in 2.5.40 (it was oopsing in .39)


-- 
* Witek Krecicki   adasi@pld.org.pl adasi@kernel.pl  GG346981 +48502117580 *
* "None but ourselves can free our minds"  -  Bob Marley,  Redemption Song *
* http://www.risingsun.org  http://www.kernel.org    http://www.pld.org.pl *
* http://risingsun.eu.org    http://www.6bone.pl    http://www.amnesty.org *

