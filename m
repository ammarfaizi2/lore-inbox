Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSLBSwQ>; Mon, 2 Dec 2002 13:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264848AbSLBSwQ>; Mon, 2 Dec 2002 13:52:16 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:54535
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264844AbSLBSwP>; Mon, 2 Dec 2002 13:52:15 -0500
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
From: Robert Love <rml@tech9.net>
To: Christoph Hellwig <hch@sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       marcelo@connectiva.com.br.munich.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021202201101.A26164@sgi.com>
References: <20021202192652.A25938@sgi.com>
	 <1919608311.1038822649@[10.10.2.3]>  <20021202201101.A26164@sgi.com>
Content-Type: text/plain
Organization: 
Message-Id: <1038855585.895.16.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 13:59:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 20:11, Christoph Hellwig wrote:

> > Marcelo, what are the chances of getting this merged into mainline
> > in the 2.4.20 timeframe?
> 
> Ingo vetoed it.

I did too.  I know the distributors (including the one I work for) want
it, but its a big change and very much a 2.5 thing.

I would not be against tuning the 2.4 scheduler, though.  But the 
changes to architecture-dependent code mean it may not even work on one
or two architectures (i.e. cris, maybe?) and so I am against the whole
O(1) scheduler and all of that supporting code for 2.4 proper.

	Robert Love

