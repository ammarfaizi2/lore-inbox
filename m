Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269056AbUJQF2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269056AbUJQF2L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 01:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269057AbUJQF2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 01:28:10 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:47060 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269056AbUJQF2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 01:28:06 -0400
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Organization: 
Message-Id: <1097990475.2673.14262.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2004 01:21:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> On Sad, 2004-10-16 at 20:52, Lee Revell wrote:
>> [Pavel Machek]

>>> What benefits? HZ=1000 takes 1W more on my system.
>>
>> Better timer resolution?
>
> And heavily reduced accuracy on a lot of laptops
> where 1000Hz is enough to make the clock slide
> every time the battery state is queried or an SMM
> event triggers.

How low is low enough for nearly all of these laptops?
Some decent choices:

wrongness_%   HZ_diff   PIT_#   HZ     actual_HZ
-0.00083809  -0.003051   3278   364   363.996949  
-0.00016762  -0.000483   4143   288   287.999517
-0.00016762  -0.000724   2762   432   431.999276
-0.00016762  -0.001448   1381   864   863.998552
+0.00008381  +0.000304   3287   363   363.000304  
+0.00008381  +0.000435   2299   519   519.000435  
+0.00008381  +0.000525   1903   627   627.000525  


