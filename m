Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262328AbSJRAUr>; Thu, 17 Oct 2002 20:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262356AbSJRAUr>; Thu, 17 Oct 2002 20:20:47 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:29435 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S262328AbSJRAUq>; Thu, 17 Oct 2002 20:20:46 -0400
Date: Thu, 17 Oct 2002 20:26:45 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Andi Kleen <ak@muc.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statfs64 no longer missing
Message-ID: <20021017202645.A3702@redhat.com>
References: <20021016140658.GA8461@averell> <shs7kgipiym.fsf@charged.uio.no> <15789.64263.606518.921166@wombat.chubb.wattle.id.au> <20021017000111.GA25054@averell> <20021017154102.D30332@redhat.com> <15791.21383.361727.533851@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15791.21383.361727.533851@wombat.chubb.wattle.id.au>; from peter@chubb.wattle.id.au on Fri, Oct 18, 2002 at 10:19:19AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 10:19:19AM +1000, Peter Chubb wrote:
> I didn't add a passed-in argument of expected size, as I think that
> statfs64 is well enough understood (and there are 5 spare longs
> anyway).

That's what we thought about fstat last time, too.  Trust me, there will 
always be a reason to add more fields, and considering that one of the 64 
bit platforms we're using today will likely still be around in 10 years, 
just adding the size parameter is easy enough to save a pile of hassel 
later.

		-ben
