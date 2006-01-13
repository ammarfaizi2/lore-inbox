Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423016AbWAMWT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423016AbWAMWT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423017AbWAMWT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:19:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34000 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423016AbWAMWT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:19:56 -0500
Date: Fri, 13 Jan 2006 14:18:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: bunk@stusta.de, rdunlap@xenotime.net, adobriyan@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
Message-Id: <20060113141839.39887ce0.akpm@osdl.org>
In-Reply-To: <20060113135210.80aabc8d.pj@sgi.com>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<20060107210646.GA26124@mipter.zuzino.mipt.ru>
	<20060107154842.5832af75.akpm@osdl.org>
	<20060110182422.d26c5d8b.pj@sgi.com>
	<20060113141154.GL29663@stusta.de>
	<20060113101054.d62acb0d.pj@sgi.com>
	<Pine.LNX.4.58.0601131014160.5563@shark.he.net>
	<20060113210848.GS29663@stusta.de>
	<Pine.LNX.4.58.0601131310060.5563@shark.he.net>
	<20060113213259.GT29663@stusta.de>
	<20060113135210.80aabc8d.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> And Andrew made a good point,

It's January - time for my annual good point.

> that matches up well with your mention
> of your "puny 1.8 GHz CPU."  There is some efficiency to be gained
> from doing crosstool builds against 100 changes at once, rather than
> 100 developers each doing them for their one change.

Of course, people other than myself can and do run cross-builds on -mm
trees, which is doubleplus efficient.  It appears that Adrian is doing
this, for one.

So the 100-or-more people write their patches, they go into -mm and then I
and a few others do the cross-compiling, feed back or fix any problems.

