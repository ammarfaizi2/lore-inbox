Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269260AbUIHRba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269260AbUIHRba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 13:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269257AbUIHRat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 13:30:49 -0400
Received: from unthought.net ([212.97.129.88]:9156 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S269259AbUIHRai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 13:30:38 -0400
Date: Wed, 8 Sep 2004 19:30:37 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: Anando Bhattacharya <a3217055@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
Message-ID: <20040908173037.GI390@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg Banks <gnb@melbourne.sgi.com>,
	Anando Bhattacharya <a3217055@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20040908123524.GZ390@unthought.net> <322909db040908080456c9f291@mail.gmail.com> <20040908154434.GE390@unthought.net> <1094661418.19981.36.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094661418.19981.36.camel@hole.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 02:36:58AM +1000, Greg Banks wrote:
> On Thu, 2004-09-09 at 01:44, Jakob Oestergaard wrote:
> > SMP systems on 2.6 have a problem with XFS+NFS.
> 
> Knfsd threads in 2.6 are no longer serialised by the BKL, and the
> change has exposed a number of SMP issues in the dcache.  Try the
> two patches at
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108330112505555&w=2
> 
> and
> 
> http://linus.bkbits.net:8080/linux-2.5/cset@1.1722.48.23
> 
> (the latter is in recent Linus kernels).  If you're still having
> problems after applying those patches, Nathan and I need to know.
> 

Ok - Anders (as@cohaesio.com) will hopefully get a test setup (similar
to the big server) running tomorrow, and will then see if the system can
be broken with these two patches applied.

Are we right in assuming that no other patches should be necessary atop
of 2.6.8.1 in order to get a stable XFS?   (that we should not apply
other XFS specific patches?)

Thanks,

-- 

 / jakob

