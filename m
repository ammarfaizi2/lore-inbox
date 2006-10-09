Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbWJIL6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbWJIL6G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWJIL6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:58:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47820 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932631AbWJIL6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:58:05 -0400
Message-ID: <452A392F.2090207@RedHat.com>
Date: Mon, 09 Oct 2006 07:57:35 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Neil Brown <neilb@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH] lockdep: annotate nfs/nfsd in-kernel sockets
References: <1160146860.2792.111.camel@taijtu>	 <17705.40741.552103.194329@cse.unsw.edu.au>	 <1160381521.2792.129.camel@taijtu>	 <17706.1827.174148.860144@cse.unsw.edu.au> <1160384069.2792.148.camel@taijtu>
In-Reply-To: <1160384069.2792.148.camel@taijtu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Mon, 2006-10-09 at 18:24 +1000, Neil Brown wrote:
>>
>>That is very much an nfs-client issue, so reclassifying the
>>server-side sockets seems irrelevant.  Doesn't cause any harm though I
>>suppose.
> 
> 
> SteveD had a case that required the svc change, Steve was that the same
> trace or another?
Through some simply 'hello world' server testing, I as able to
make these locking dependence warnings pop...

steved.
