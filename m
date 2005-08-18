Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVHRRku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVHRRku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHRRku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:40:50 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:49028 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932337AbVHRRkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:40:49 -0400
Date: Thu, 18 Aug 2005 19:42:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       sudoyang@gmail.com
Subject: Re: compiling only one module in kernel version 2.6?
Message-ID: <20050818174255.GA8457@mars.ravnborg.org>
References: <4f52331f050816190957cec081@mail.gmail.com> <1124248729.5764.70.camel@localhost.localdomain> <20050816224101.295806c8.rdunlap@xenotime.net> <1124257739.5764.107.camel@localhost.localdomain> <1124258090.5764.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124258090.5764.109.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 01:54:50AM -0400, Steven Rostedt wrote:
> On Wed, 2005-08-17 at 01:48 -0400, Steven Rostedt wrote:
> > On Tue, 2005-08-16 at 22:41 -0700, Randy.Dunlap wrote:
> > > 
> > > Sam only added make .ko build support very recently,
> > > so it could easily depend on what kernel verison Fong is using.
> > 
> > That could very well explain it. I'm doing this on 2.6.13-rc6-rt6
> > (2.6.13-rc6 with Ingo's rt6 patch applied).  So I really do have a
> > recent kernel.
> > 
> 
> I just did this on a 2.6.9 vanilla kernel, and it still worked.

Hi Steve.

make fs/reiserfs/
and
make fs/reiserfs/resiserfs.ko

does not do the same thing. Only the latter result in a .ko file.

	Sam
