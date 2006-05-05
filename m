Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWEEFVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWEEFVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 01:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWEEFVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 01:21:35 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:11791 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932464AbWEEFVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 01:21:35 -0400
Date: Fri, 5 May 2006 07:20:42 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.14
Message-ID: <20060505052042.GA28568@w.ods.org>
References: <20060505003526.GW24291@moss.sous-sol.org> <200605051303.37130.ncunningham@cyclades.com> <20060505045003.GD11191@w.ods.org> <200605051502.53481.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605051502.53481.ncunningham@cyclades.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 03:02:47PM +1000, Nigel Cunningham wrote:
> Hi Willy.
(snip)
> 
> I didn't mention it previously - I guess because it was subconscious - but I'm 
> looking at things from the point of view of someone maintaining an 
> out-of-tree patch. With almost all of these revisions, my patch continues to 
> apply cleanly, but I still get people asking "Is the patch for 2.6.16.9" safe 
> to apply against "2.6.16.9+x"? I simply don't have the time to continually 
> test and check, but I end up feeling like there's a new 2.6.x release 
> everyday that I just have to keep up with, because that's what the stable 
> users want. Maybe it just proves that I should hurry up and get the git tree 
> finished so I get try to get Suspend2 merged :)

Oh yes, I understand your problem, I went through that for several years with
2.4. Another advantage of many small updates is that the risk of conflict is
minor, and your users might often be able to apply the official patch *after*
your patch, which is very convenient.

Maybe you should just run a cron script to patch your kernels everytime a
new fix goes out, so that you'll at least be able to reply to your users
whether it's supposed to work or not.

> Regards,
> 
> Nigel

Regards,
Willy

