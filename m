Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVIHUYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVIHUYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVIHUYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:24:22 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:37299 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964982AbVIHUYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:24:21 -0400
Message-ID: <43209DEB.1020301@nortel.com>
Date: Thu, 08 Sep 2005 14:24:11 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Willy Tarreau <willy@w.ods.org>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
References: <35547.10.10.10.10.1125892279.squirrel@linux1> <20050905040311.29623.qmail@web50204.mail.yahoo.com> <50570.10.10.10.10.1125893576.squirrel@linux1> <20050905043613.GD30279@alpha.home.local> <4320989E.3080603@tmr.com>
In-Reply-To: <4320989E.3080603@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2005 20:24:13.0738 (UTC) FILETIME=[473EF0A0:01C5B4B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> It appears that Linus has decided that there are not going to be any 
> such from kernel.org. That's a bad thing for users, to choose between 
> obsolete and stable, but it's his kernel.

Most users are best served to stick with the latest kernel *from their 
distro*.  It's only the developers and the distro maintainers that need 
to worry about tracking the latest kernel.

Of course there are a lot of enthusiasts that do it as well, but there 
has been a caveat for quite a while that if you track the bleeding edge, 
you really should be on the mailing lists so that you know what's going 
on and which issues might bite you.

There is a cost to maintaining features in the kernel, even something 
like multiple stack sizes.  Whenever you have a config option, you need 
to worry about making sure that everything works both ways.  This takes 
time and resources.  There's always going to be a push to simplify things.

Chris
