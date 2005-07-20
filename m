Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVGTH5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVGTH5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 03:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVGTH5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 03:57:18 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:44740 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261202AbVGTH5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 03:57:17 -0400
Date: Wed, 20 Jul 2005 09:57:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kerin Millar <kerframil@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Noob question. Why is the for-pentium4 kernel built with
 -march=i686 ?
In-Reply-To: <pan.2005.07.20.08.03.25.15476@gmail.com>
Message-ID: <Pine.LNX.4.61.0507200956240.22689@yvahk01.tjqt.qr>
References: <1121792852.11857.6.camel@home.yosifov.net>
 <Pine.LNX.4.61.0507191950020.89@yvahk01.tjqt.qr> <1121798151.15700.9.camel@home.yosifov.net>
 <pan.2005.07.20.08.03.25.15476@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Also, I believe that the -march=pentium4 option /was/ actually used up
>until kernel 2.6.10 where it was dropped because of a risk that some
>versions of gcc would cause the kernel to use SSE registers for data
>movement (which is a no-no).

In that case, -mno-sse should have been used.



Jan Engelhardt
-- 
