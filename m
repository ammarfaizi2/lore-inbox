Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSJRGZn>; Fri, 18 Oct 2002 02:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264967AbSJRGZn>; Fri, 18 Oct 2002 02:25:43 -0400
Received: from zero.aec.at ([193.170.194.10]:28176 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S264877AbSJRGZl>;
	Fri, 18 Oct 2002 02:25:41 -0400
Date: Fri, 18 Oct 2002 08:31:29 +0200
From: Andi Kleen <ak@muc.de>
To: Peter Chubb <peter@chubb.wattle.id.au>, Benjamin LaHaise <bcrl@redhat.com>,
       Andi Kleen <ak@muc.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statfs64 no longer missing
Message-ID: <20021018063129.GA24682@averell>
References: <20021016140658.GA8461@averell> <shs7kgipiym.fsf@charged.uio.no> <15789.64263.606518.921166@wombat.chubb.wattle.id.au> <20021017000111.GA25054@averell> <20021017154102.D30332@redhat.com> <15791.21383.361727.533851@wombat.chubb.wattle.id.au> <20021018061701.GA18925@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018061701.GA18925@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wasn't Dave Miller just saying that passing "long" between user-space
> and the kernel is just a bad idea?  Should we use "__u32" and "__u64"
> here instead?

This is architecture specific, where it is ok.

-Andi
