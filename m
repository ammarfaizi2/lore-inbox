Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWDPKhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWDPKhN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 06:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWDPKhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 06:37:13 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:49875 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750702AbWDPKhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 06:37:11 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: was Re: quell interactive feeding frenzy
Date: Sun, 16 Apr 2006 20:37:01 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org
References: <200604112100.28725.kernel@kolivas.org> <200604161602.22177.kernel@kolivas.org> <200604161131.02585.a1426z@gawab.com>
In-Reply-To: <200604161131.02585.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604162037.02044.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Since you have an unhealthy interest in cpu schedulers you may also want to 
look at my ultimate fairness with mild interactivity builtin cpu scheduler I 
hacked on briefly. I was bored for a couple of days and came up with the 
design and hacked it together. I never got around to finishing it to live up 
fully to its design intent but it's working embarassingly well at the moment. 
It makes no effort to optimise for interactivity in anyw way. Maybe if I ever 
find some spare time I'll give it more polish and port it to plugsched. 
Ignore the lovely name I give it; the patch is for 2.6.16. It's a dual 
priority array rr scheduler that iterates over all priorities. This is as 
opposed to staircase which is a single priority array scheduler where the 
tasks themselves iterate over all priorities.

http://ck.kolivas.org/patches/crap/sched-crap-1.patch

-- 
-ck
