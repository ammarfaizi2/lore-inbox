Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318621AbSGZW7i>; Fri, 26 Jul 2002 18:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318622AbSGZW7i>; Fri, 26 Jul 2002 18:59:38 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:22931 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318621AbSGZW7h>;
	Fri, 26 Jul 2002 18:59:37 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 26 Jul 2002 16:55:35 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>, Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()]
Message-ID: <20020726165535.R13656@host110.fsmlabs.com>
References: <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random> <20020725150525.Q2276@host110.fsmlabs.com> <20020725220643.GT1180@dualathlon.random> <20020725160559.X2276@host110.fsmlabs.com> <20020725225613.GW1180@dualathlon.random> <20020725170113.F5326@host110.fsmlabs.com> <20020726223750.GA1151@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020726223750.GA1151@dualathlon.random>; from andrea@suse.de on Sat, Jul 27, 2002 at 12:37:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see how this is significantly different from the patch I sent
apart from removing some useful debugging.  Is there something I'm missing?

The patch I sent prints out the offset from the symbol name nearest
(below) the EIP and the offset from that symbol.  I found that really
useful and was what I use the patch for.  Is there a reason you don't want
that?  I know you had some cases where all symbols weren't listed for you
but many of us do have those symbols we'd like to see.
