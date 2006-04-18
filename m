Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWDRHaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWDRHaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 03:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWDRHaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 03:30:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41609 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751118AbWDRHaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 03:30:16 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Arjan van de Ven <arjan@infradead.org>
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       Mingming Cao <cmm@us.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1145344481.17767.1.camel@openx2.frec.bull.fr>
References: <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
	 <1144660270.5816.3.camel@openx2.frec.bull.fr>
	 <20060410012431.716d1000.akpm@osdl.org>
	 <1144941999.2914.1.camel@openx2.frec.bull.fr>
	 <20060417210746.GB3945@localhost.localdomain>
	 <1145308176.2847.90.camel@laptopd505.fenrus.org>
	 <20060417213201.GC3945@localhost.localdomain>
	 <1145344481.17767.1.camel@openx2.frec.bull.fr>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Apr 2006 09:30:07 +0200
Message-Id: <1145345407.2976.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 09:14 +0200, Laurent Vivier wrote:
> Le lun 17/04/2006 à 23:32, Ravikiran G Thirumalai a écrit :
> > On Mon, Apr 17, 2006 at 11:09:36PM +0200, Arjan van de Ven wrote:
> > > On Mon, 2006-04-17 at 14:07 -0700, Ravikiran G Thirumalai wrote:
> > > > 
> > > > 
> > > > I ran the same tests on a 16 core EM64T box very similar to the one
> > > > you ran
> > > > dbench on :). Dbench results on ext3 varies quite a bit.  I couldn't
> > > > get 
> > > > to a statistically significant conclusion  For eg,
> > > 
> > > 
> > > dbench is not a good performance benchmark. At all. Don't use it for
> > > that ;)
> > 
> > Agreed. (I did not mean to use it in the first place :).  I was just trying 
> > to verify the benchmark results posted earlier)
> > 
> > Thanks,
> > Kiran
> 
> What is the good performance benchmark to know if we should use atomic_t
> instead of percpu_counter ?

you probably want something like postal/postmark instead or so (although
that's not ideal either), at least that's reproducable

