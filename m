Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVGWJWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVGWJWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 05:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVGWJWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 05:22:15 -0400
Received: from main.gmane.org ([80.91.229.2]:9359 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261653AbVGWJWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 05:22:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jesper Krogh <jesper@krogh.cc>
Subject: Re: Giving developers clue how many testers verified certain kernel version
Date: Sat, 23 Jul 2005 09:21:49 +0000 (UTC)
Message-ID: <dbt27d$mre$1@sea.gmane.org>
References: <200507230244.11338.blaisorblade@yahoo.it>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: linuxnews.dk
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gmane.linux.kernel, skrev Blaisorblade:
>  Forgot drivers testing? That is where most of the bugs are hidden, and where 
>  wide user testing is definitely needed because of the various hardware bugs 
>  and different configurations existing in real world.

A way that could raise the testing upon a particular kernel, would be to
provide; (debian example follows):
... example .. 
An apt-repository with the newest tagged kernel build modular for the
architecture. 

Just drop all tagged kernels in a common repository that the users can
follow, then I'd be happy to test a new kernel on every reboot on my
system. I'd probably still would respond if anything was broken in the
new kernel.. 

Then it wouldn't be: "try this patch and see if that solves anything"
but do:

apt-get install kernel-image-386-torvalds-linux-2.6-v2.6.13-rc3

(automatically build from the "torvalds/linux-2.6"-branch with tag
"v2.6.13-rc3" using a modular kernel-configuration similar to the one
used in the stock debian kernels.  

Then I find and report something and "Pavel Machek" releases a "try-fix", by
tagging a branch ind a tree and tells me to try
kernel-image-386-pavel-good-2.6-v2.6.13-rc3 
instead. 

(and variations.. acip/no-acip smp, etc. etc. )

... example end .. 


It would be quite a lot central kernel-building, but as far as I can
see, it can be fully automated. 

It would defininately lower the barrier for being able to paticipate in
testing, but I am not the one to decide if that would be a desirable
goal?  Or for that matter, worth the work. 

Jesper
-- 
./Jesper Krogh, jesper@krogh.cc, Jabber ID: jesper@jabbernet.dk


