Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269102AbUI2WSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269102AbUI2WSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269172AbUI2WR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:17:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:39853 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269179AbUI2WRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:17:11 -0400
Date: Wed, 29 Sep 2004 15:16:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Jakob Oestergaard <jakob@unthought.net>, neilb@cse.unsw.edu.au,
       Greg Banks <gnb@melbourne.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Anando Bhattacharya <a3217055@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Re: Major XFS problems...
In-Reply-To: <20040929224558.A18353@infradead.org>
Message-ID: <Pine.LNX.4.58.0409291515040.2317@ppc970.osdl.org>
References: <20040908123524.GZ390@unthought.net> <322909db040908080456c9f291@mail.gmail.com>
 <20040908154434.GE390@unthought.net> <1094661418.19981.36.camel@hole.melbourne.sgi.com>
 <20040909140017.GP390@unthought.net> <20040913072918.GU390@unthought.net>
 <20040917112647.GC390@unthought.net> <20040929224558.A18353@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Sep 2004, Christoph Hellwig wrote:
> 
> Neil, any chance we could get this patch into mainline ASAP?  Without
> it we get ->get_parent called on non-directories under heavy NFS loads..

Sorry, my bad. I had asked Al to ack it a long time ago, and he said 
"looks ok, want more background", and I never got around to that. 

The patch looks right, nobody really complains, so I applied it.

		Linus
