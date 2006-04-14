Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWDNRWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWDNRWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWDNRWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:22:10 -0400
Received: from ns1.siteground.net ([207.218.208.2]:63881 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751310AbWDNRWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:22:08 -0400
Date: Fri, 14 Apr 2006 10:23:01 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: Mingming Cao <cmm@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Takashi Sato <sho@tnes.nec.co.jp>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
Message-ID: <20060414172301.GB3740@localhost.localdomain>
References: <20060327225847.GC3756@localhost.localdomain> <1143530126.11560.6.camel@openx2.frec.bull.fr> <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com> <1143623605.5046.11.camel@openx2.frec.bull.fr> <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com> <20060329175446.67149f32.akpm@osdl.org> <1144660270.5816.3.camel@openx2.frec.bull.fr> <1144688279.3964.7.camel@dyn9047017067.beaverton.ibm.com> <1144696012.3964.76.camel@dyn9047017067.beaverton.ibm.com> <1144739259.9786.5.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144739259.9786.5.camel@openx2.frec.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Tue, Apr 11, 2006 at 09:07:39AM +0200, Laurent Vivier wrote:
> ...  
> I made some tests with iozone on 2 CPU hyperthreaded computer (= 4 CPUs,
> Bull Express 5800 120 Lh), and it seems atomic_t is faster than
> "percpu_counter". I'll try to make some tests on IBM x440 (8 CPUs, 16 if
> hyperthreaded) with iozone and sysbench.
> Moreover, I think percpu_counter uses a lot of memory...

Was this just one iozone thread doing io?  What was the performance
difference?  Please let me know what kind of test you are doing, and I can 
run the same on an IBM x460 with 16 cores here.

Thanks,
Kiran
