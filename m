Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVDKPV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVDKPV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVDKPV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:21:56 -0400
Received: from pat.uio.no ([129.240.130.16]:39349 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261799AbVDKPVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:21:55 -0400
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make
	sense
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050411144127.GE13369@unthought.net>
References: <20050406160123.GH347@unthought.net>
	 <20050406231906.GA4473@sgi.com> <20050407153848.GN347@unthought.net>
	 <1112890671.10366.44.camel@lade.trondhjem.org>
	 <20050409213549.GW347@unthought.net>
	 <1113083552.11982.17.camel@lade.trondhjem.org>
	 <20050411074806.GX347@unthought.net>
	 <1113222939.14281.17.camel@lade.trondhjem.org>
	 <20050411134703.GC13369@unthought.net>
	 <1113230125.9962.7.camel@lade.trondhjem.org>
	 <20050411144127.GE13369@unthought.net>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Apr 2005 11:21:45 -0400
Message-Id: <1113232905.9962.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.48, required 12,
	autolearn=disabled, AWL 1.52, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 11.04.2005 Klokka 16:41 (+0200) skreiv Jakob Oestergaard:

> > That can mean either that the server is dropping fragments, or that the
> > client is dropping the replies. Can you generate a similar tcpdump on
> > the server?
> 
> Certainly;  http://unthought.net/sparrow.dmp.bz2

So, it looks to me as if "sparrow" is indeed dropping packets (missed
sequences). Is it running with NAPI enabled too?

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

