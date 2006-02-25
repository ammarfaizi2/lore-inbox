Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWBYWF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWBYWF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWBYWF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:05:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35980 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750775AbWBYWF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:05:28 -0500
Date: Sat, 25 Feb 2006 23:05:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, Adam Kropelin <akropel1@rochester.rr.com>,
       Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/nbd.c: don't defer compile error to
 runtime (fwd)
In-Reply-To: <20060225160153.GY3674@stusta.de>
Message-ID: <Pine.LNX.4.61.0602252304490.10677@yvahk01.tjqt.qr>
References: <20060225160153.GY3674@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>If we can detect a problem at compile time, the compilation should fail.
>

Hi,

do the same with fs/minix/*, it also checks sizeof() to 32/64 at runtime.



Jan Engelhardt
-- 
