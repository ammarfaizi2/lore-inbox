Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbTE0UrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264204AbTE0UrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:47:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32152 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264183AbTE0UrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:47:02 -0400
Date: Tue, 27 May 2003 23:00:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527210019.GA845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <200305272224.22567.m.c.p@wolk-project.de> <20030527204519.GQ3767@dualathlon.random> <200305272253.06726.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272253.06726.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27 2003, Marc-Christian Petersen wrote:
> On Tuesday 27 May 2003 22:45, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > > I try to backport BIO and then AS for quite over 2 weeks now, but it
> > > seems, at least for me, that it's an impossible mission ;(
> > bio breaks all drivers, not a good idea to backport ;)
> HAHAHAH. Another wasted 2 weeks in my life ;-)
> 
> But why does it brake all drivers? Could you please elaborate a bit?

Are you serious? Please tell me you haven't spend two weeks on the
project not realising this?

I think the problem here is that you are saying 'bio' when you really
mean something else. bio is the 2.5 io structure. What _exactly_ do you
mean with 'backporting bio'? I don't think you have the slightest idea
of the nastiness involved with doing something like that.

-- 
Jens Axboe

