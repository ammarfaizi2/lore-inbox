Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVGTOxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVGTOxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVGTOvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:51:41 -0400
Received: from mail.portrix.net ([212.202.157.208]:19367 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261280AbVGTOta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:49:30 -0400
Message-ID: <42DE6472.9080808@ppp0.net>
Date: Wed, 20 Jul 2005 16:49:22 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rbt <rbt@athop1.ath.vt.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Automating Kernel Builds
References: <1121869302.8610.10.camel@athop1.ath.vt.edu>
In-Reply-To: <1121869302.8610.10.camel@athop1.ath.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rbt wrote:
> I have a script that automatically builds kernels for testing. Would it
> be possible to put the kernel version number (2.6.12.3) into the
> 'LATEST-IS-VERSION' file on http://www.kernel.org/pub/linux/kernel/v2.6/
> or, is there some other file that traditionally has stored this info? I
> searched the repository but could not find one.
> 
> As of now, my script goes to the site and parses the page searching for
> a line that contains 'LATEST-IS' and then breaks that line apart and
> attempts to extract the kernel version number from it. If
> LATEST-IS-VERSION actually contained the version number (2.6.12.3)
> instead of being a 0 byte file as it is now, then it my script could
> simply read it and not have to do funky html parsing to get the latest
> version number ;)

Some things from the top of my mind:

a) /\d+\.\d+\.\d+(\.\d+)?/
b) use ftp://
c) http://kernel.org/kdist/rss.xml
d) http://www.kernel.org/kdist/finger_banner

ps: you know http://l4x.org/k/ and kerncomp.sf.net?

-- 
Jan
