Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUIJCee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUIJCee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUIJCee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:34:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38825 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267386AbUIJCdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:33:36 -0400
Subject: Re: Major XFS problems...
From: Greg Banks <gnb@melbourne.sgi.com>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Anando Bhattacharya <a3217055@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040909140017.GP390@unthought.net>
References: <20040908123524.GZ390@unthought.net>
	 <322909db040908080456c9f291@mail.gmail.com>
	 <20040908154434.GE390@unthought.net>
	 <1094661418.19981.36.camel@hole.melbourne.sgi.com>
	 <20040909140017.GP390@unthought.net>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1094784025.19981.188.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 10 Sep 2004 12:40:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 00:00, Jakob Oestergaard wrote:
> On Thu, Sep 09, 2004 at 02:36:58AM +1000, Greg Banks wrote:
> > On Thu, 2004-09-09 at 01:44, Jakob Oestergaard wrote:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=108330112505555&w=2
> 
> Ok, I must say that mail has some *scary* comments to the patch... This
> should be interesting  :)

Like I said, knfsd does unnatural things to the dcache.

> I'm assuming I should just adapt this to the res->d_bucket change...

Yes, there were a bunch of dcache changes all happening around
that time, this patch may well need some merging.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


