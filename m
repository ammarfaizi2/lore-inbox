Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTIDDDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTIDDDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:03:23 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:50051 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264539AbTIDDDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:03:15 -0400
Date: Wed, 3 Sep 2003 20:02:27 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030904030227.GJ5227@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, "Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com> <20030903173213.GC5769@work.bitmover.com> <89360000.1062613076@flay> <20030904003633.GA5227@work.bitmover.com> <6130000.1062642088@[10.10.2.4]> <20030904023446.GG5227@work.bitmover.com> <9110000.1062643682@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9110000.1062643682@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=1.9,
	required 7, AWL, DATE_IN_PAST_06_12, MONEY_MAKING)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 07:48:03PM -0700, Martin J. Bligh wrote:
> >> --Larry McVoy <lm@bitmover.com> wrote (on Wednesday, September 03, 2003 17:36:33 -0700):
> >> > They have to be, CPUs are fast enough
> >> > to handle most problems, clustering has worked for lots of big companies
> >> > like Google, Amazon, Yahoo, and the HPC market has been flat for years.
> >> > So where's the growth?  Nowhere I can see.  If I'm not seeing it, show
> >> > me the data.  I may be a pain in the ass but I'll change my mind instantly
> >> > when you show me data that says something different than what I believe.
> >> > So far, all I've seen is people having fun proving that their ego is
> >> > bigger than the next guys, no real data.  Come on, you'd love nothing
> >> > better than to prove me wrong.  Do it.  Or admit that you can't.
> >> 
> >> Not quite sure why the onus is on the rest of us to disprove your pet
> >> theory, rather than you to prove it.
> > 
> > Maybe because history has shown over and over again that your pet theory
> > doesn't work.  Mine might be wrong but it hasn't been proven wrong.  Yours
> > has.  Multiple times.
> 
> Please, this makes no sense. Why do you think IBM and others make large
> machines? Stupidity? 

I designed and shipped servers for Sun, I know exactly why they do it.
Customers want to know they have a growth path if they need it.  It's an
absolute truism in selling that you need three models: the low end,
the middle of the road, the high end.  The stupid cheap people (I've
been one of those, don't buy a car without air conditioning, it's dumb)
buy the low end, the vast majority buy the middle of the road, and a
handful of people buy the high end.

You don't make that much money, if any, on the high end, the R&D costs
dominate.  But you make money because people buy the middle of the road
because you have the high end.  If you don't, they feel uneasy that they
can't grow with you.  The high end enables the sales of the real money
makers.  It's pure marketing, the high end could be imaginary and as
long as you convinced the customers you had it you'd be more profitable.

I also worked on servers at SGI.  At both Sun and SGI, all the money
was made on 4P and less and on disks.  The big iron looks like it is
profitable but only when you don't count the R&D.

The problem with the old school approach of low/middle/high is that
everyone knows that they are shouldering far more than the material
costs plus a little profit when buying high end.  They are paying for
the R&D.  The market for those machines is very small and the volumes
never approach the level where the R&D is lost in the noise, that's a
significant fraction of the purchase price.  That's OK as long as there
is no alternative but with all the household name companies like Google,
Amazon, Yahoo, etc demonstrating that racks of 1U boxes is a far better
answer the market for the big boxes is shrinking.  Which is exactly what
Dell was saying.  I dunno, maybe I'm completely confused but I see his
point.  I don't see yours.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
