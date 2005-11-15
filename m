Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVKOTti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVKOTti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVKOTth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:49:37 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:61959 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S964996AbVKOTth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:49:37 -0500
From: Meelis Roos <mroos@linux.ee>
To: jmerkey@wolfmountaingroup.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: <437A0E7E.2080209@wolfmountaingroup.com>
User-Agent: tin/1.7.10-20050815 ("Grimsay") (UNIX) (Linux/2.6.14-g741b2252 (i686))
Message-Id: <20051115194935.5801914200@rhn.tartu-labor>
Date: Tue, 15 Nov 2005 21:49:35 +0200 (EET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JVM> No one is crying about ndiswrapper, some folks just want to use Linux on 
JVM> their laptops without waiting
JVM> two years for all the drivers to port to Linux.  Make the 4K stack 
JVM> setting a command line option.   Problem solved.

Just do a "fgrep -rI CONFIG_4KSTACKS linux" and see that this is just
not a matter of one malloc call but the code differs in many things.
That's what gives 4KSTACKS its strength.

-- 
Meelis Roos
