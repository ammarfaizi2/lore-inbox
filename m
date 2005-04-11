Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVDKOld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVDKOld (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 10:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVDKOlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 10:41:32 -0400
Received: from unthought.net ([212.97.129.88]:5552 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261752AbVDKOl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 10:41:28 -0400
Date: Mon, 11 Apr 2005 16:41:27 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050411144127.GE13369@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
References: <20050406160123.GH347@unthought.net> <20050406231906.GA4473@sgi.com> <20050407153848.GN347@unthought.net> <1112890671.10366.44.camel@lade.trondhjem.org> <20050409213549.GW347@unthought.net> <1113083552.11982.17.camel@lade.trondhjem.org> <20050411074806.GX347@unthought.net> <1113222939.14281.17.camel@lade.trondhjem.org> <20050411134703.GC13369@unthought.net> <1113230125.9962.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1113230125.9962.7.camel@lade.trondhjem.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 10:35:25AM -0400, Trond Myklebust wrote:
> må den 11.04.2005 Klokka 15:47 (+0200) skreiv Jakob Oestergaard:
> 
> > Certainly;
> > 
> > http://unthought.net/binary.dmp.bz2
> > 
> > I got an 'invalid snaplen' with the 90000 you suggested, the above dump
> > is done with 9000 - if you need another snaplen please just let me know.
> 
> So, the RPC itself looks good, but it also looks as if after a while you
> are running into some heavy retransmission problems with TCP too (at the
> TCP level now, instead of at the RPC level). When you get into that
> mode, it looks as if every 2nd or 3rd TCP segment being sent from the
> client is being lost...

Odd...

I'm really sorry for using your time if this ends up being just a
networking problem.

> That can mean either that the server is dropping fragments, or that the
> client is dropping the replies. Can you generate a similar tcpdump on
> the server?

Certainly;  http://unthought.net/sparrow.dmp.bz2


-- 

 / jakob

