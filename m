Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSGHCQy>; Sun, 7 Jul 2002 22:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSGHCQx>; Sun, 7 Jul 2002 22:16:53 -0400
Received: from ns.purdue.org ([206.230.5.18]:35260 "EHLO ns")
	by vger.kernel.org with ESMTP id <S316739AbSGHCQw>;
	Sun, 7 Jul 2002 22:16:52 -0400
Date: Sun, 7 Jul 2002 21:13:51 -0500
From: Kyler Laird <Kyler@Lairds.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.5.* Aironet driver needs linux/tqueue.h
Message-ID: <20020708021351.GL20231@jowls.lairds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I reported this to a maintainer awhile ago, but I just
tried 2.5.25 and noticed I needed to fix things again,
so I'm trying here.]

These files
	drivers/net/wireless/airo.c
	drivers/net/aironet4500.h
need to have
	#include <linux/tqueue.h>
added to them.

It seems to work fine with this modification.

--kyler

