Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUIMH3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUIMH3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 03:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUIMH3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 03:29:23 -0400
Received: from unthought.net ([212.97.129.88]:5255 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S266257AbUIMH3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 03:29:20 -0400
Date: Mon, 13 Sep 2004 09:29:19 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg Banks <gnb@melbourne.sgi.com>,
       Anando Bhattacharya <a3217055@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: Re: Major XFS problems...
Message-ID: <20040913072918.GU390@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg Banks <gnb@melbourne.sgi.com>,
	Anando Bhattacharya <a3217055@gmail.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <20040908123524.GZ390@unthought.net> <322909db040908080456c9f291@mail.gmail.com> <20040908154434.GE390@unthought.net> <1094661418.19981.36.camel@hole.melbourne.sgi.com> <20040909140017.GP390@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909140017.GP390@unthought.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 04:00:17PM +0200, Jakob Oestergaard wrote:
> 
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=108330112505555&w=2
> 
> Ok, I must say that mail has some *scary* comments to the patch... This
> should be interesting  :)
...
> 
> I'm assuming I should just adapt this to the res->d_bucket change...
> 
> New patch against 2.6.8.1 attached.
> 

Ok - the "small" box has been running with this patch since yesterday
evening - I ran some stress testing on it for some hours yesterday, and
will be working on the machine all day today.

So far, it seems like the patch at least hasn't broken anything (if I
had file corruption I should have noticed already, because the testing
I've been doing is some large compile/link jobs - those things tend to
fail if the .o files are corrupted).

It's a little early to say if it solves the problem. I would say it
looks good so far - but let's see.

We'll also have to see about the test setup duplicating the "large" box.

I'll let you know if anything breaks - and I'll ask to have the patch
included by the end of the week, if the small box hasn't hosed itself by
then.

-- 

 / jakob

