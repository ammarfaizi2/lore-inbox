Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWHWPg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWHWPg1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWHWPg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:36:26 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:59276 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964984AbWHWPg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:36:26 -0400
Date: Wed, 23 Aug 2006 17:36:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Rich Paredes <rparedes@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMP Affinity and nice
In-Reply-To: <38798.127.0.0.1.1156346673.squirrel@forexproject.com>
Message-ID: <Pine.LNX.4.61.0608231735210.9588@yvahk01.tjqt.qr>
References: <38798.127.0.0.1.1156346673.squirrel@forexproject.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject: SMP Affinity and nice
>
>I am trying to come to an understanding as to why 1 process is getting
>less cpu time than identical processes with a higher "nice" value.
>Server has 2 physical processors with hyperthreading (cpu 0,1,2,3)
>
>I am starting 5 processes that perform a square root loop to max out a
>cpu.  They use the exact same code but are renamed for identification:
>cpumax1, cpumax2, cpumax3, cpumax4, cpumax5
[...]

What you describe should be addressed in the -ck patchset (smpnice-...diff) 
Not sure if it is in mainline already, though.



Jan Engelhardt
-- 
