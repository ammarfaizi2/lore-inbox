Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270691AbTHSOzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTHSOzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:55:13 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:2970 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S270691AbTHSOzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:55:09 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Surges of repeated input events in 2.6.0-test3-bk1?
Date: Tue, 19 Aug 2003 06:09:44 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308190609.44691.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every once in a while, I'll get a surge of repeated input events, repeating 
really fast for about half a second.  Just now it was the m key repeating 
really fast for about half a second when I only hit it once, and before that 
I was scrolling a window down using the down arrow under the scrollbar with 
the rat, and it surged down for about half a second when I only clicked it 
once.  (Each time the result was equal to a half-dozen clicks/keypresses when 
I only did one...)

Judging by the loadmeter thing in kde, this seems to coincide with a spike of 
red (system) CPU usage.  Not a clue what causes that, KDE is up and it's got 
background processes out the wazoo...

Just thought I'd yell.  Vanilla test3-bk1, no patches applied at the moment.  
Running on an otherwise stock Red Hat 9 system.  (Everything compiled 
monolithic, so I didn't even have to change modutils.)  I'll upgrade to a 
newer kernel in a bit and let you know if it happens more.  (It's not exactly 
a common thing, I've seen it twice in the past hour.  It's annoying when it 
happens, though...)

(It's like the release event is getting delayed by some kind of latency spike, 
but some kind of ultra-fast repeat mechanism's triggering immediately...)

Rob


