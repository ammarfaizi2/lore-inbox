Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTENMq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTENMqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:46:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23454 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262069AbTENMqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:46:52 -0400
Date: Wed, 14 May 2003 14:59:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: 2.5 qdisc problem
Message-ID: <20030514125941.GI15261@suse.de>
References: <20030514070600.GV17033@suse.de> <20030514122624.GA20480@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514122624.GA20480@babylon.d2dc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, Zephaniah E. Hull wrote:
> On Wed, May 14, 2003 at 09:06:00AM +0200, Jens Axboe wrote:
> > Hi,
> > 
> > I put 2.5 on my router, and now wondershaper doesn't work anymore. Am I
> > completely out of whack, or shouldn't the below just fly:
> > 
> > router:~ # tc -s qdisc ls dev lo
> > RTNETLINK answers: Invalid argument
> > Dump terminated
> > 
> > I have the various QOS stuff enabled (config attached, and I don't seem
> > to be missing anything. So what is up?
> 
> Good question, I've been seeing it since I moved from 2.5.68-mm2 to
> 2.5.68-mm4, from what I can tell it was something in Linus' bk that was
> pulled in that killed it.
> 
> However I have had no luck at all trying to figure out what exactly
> broke.

Interesting, I didn't know it broke that recently. Looking at changes
between -mm2 and -mm4 doesn't reveal a lot, really... Acme made most of
the changes there it seems, any ideas?

-- 
Jens Axboe

