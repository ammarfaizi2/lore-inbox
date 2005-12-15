Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbVLOWzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVLOWzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVLOWzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:55:25 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:38623 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750985AbVLOWzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:55:24 -0500
Date: Thu, 15 Dec 2005 23:55:05 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Reduce nr of ptr derefs in fs/jffs2/summary.c
In-Reply-To: <200512110640.48356.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.61.0512152354240.13568@yvahk01.tjqt.qr>
References: <200512110640.48356.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Benefits:
> - micro speed optimization due to fewer pointer derefs
> - generated code is slightly smaller

Should not these two at best be done by the compiler?



Jan Engelhardt
-- 
