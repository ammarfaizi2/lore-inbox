Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUGLXyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUGLXyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUGLXyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:54:38 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:1274 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S264299AbUGLXy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:54:26 -0400
Message-Id: <200407122354.i6CNsNqS003382@localhost.localdomain>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, florin@sgi.com
Subject: Re: desktop and multimedia as an afterthought? 
In-reply-to: Your message of "12 Jul 2004 16:45:54 EDT."
             <1089665153.1231.88.camel@cube> 
Date: Mon, 12 Jul 2004 19:54:23 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [141.151.61.237] at Mon, 12 Jul 2004 18:54:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It's too bad that the multimedia community didn't participate
>much during the 2.5.xx development leading up to 2.6.0. If they
>had done so, the situation might be different today. Fortunately,
>fixing up the multimedia problems isn't too risky to do during
>the stable 2.6.xx series.

I regret that this description is persisting here. "We" (the audio
developer community) did not participate because it was made clear
that our needs were not going to be considered. We were told that the
preemption patch was sufficient to provide "low latency", and that
rescheduling points dotted all over the place was bad engineering
(probably true). With this as the pre-rendered verdict, there's not a
lot of point in dedicating time to tracking a situation that clearly
is not going to work.

The kernel is not going to provide adequate latency for multimedia
needs without either (1) latency issues being front and center in
every kernel developer's mind, which seems unlikely and/or (2)
conditional rescheduling points added to the kernel, which appears to
require non-mainstreamed patches.

--p

  
