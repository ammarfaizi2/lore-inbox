Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVDFFRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVDFFRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 01:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVDFFRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 01:17:37 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:8967 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262106AbVDFFR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 01:17:26 -0400
Date: Tue, 5 Apr 2005 22:17:40 -0700
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for asynchronous I/O
Message-ID: <20050406051740.GA8045@nietzsche.lynx.com>
References: <1112224663.18019.39.camel@lade.trondhjem.org> <1112309586.27458.19.camel@lade.trondhjem.org> <20050331161350.0dc7d376.akpm@osdl.org> <1112318537.11284.10.camel@lade.trondhjem.org> <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com> <20050404162216.GA18469@kvack.org> <1112637395.10602.95.camel@lade.trondhjem.org> <20050405154641.GA27279@kvack.org> <1112750457.14586.53.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112750457.14586.53.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.8i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 09:20:57PM -0400, Trond Myklebust wrote:
> ty den 05.04.2005 Klokka 11:46 (-0400) skreiv Benjamin LaHaise:
> 
> > I can see that goal, but I don't think introducing iosems is the right 
> > way to acheive it.  Instead (and I'll start tackling this), how about 
> > factoring out the existing semaphore implementations to use a common 
> > lib/semaphore.c, much like lib/rwsem.c?  The iosems can be used as a 
> > basis for the implementation, but we can avoid having to do a giant 
> > s/semaphore/iosem/g over the kernel tree.
> 
> If you're willing to take this on then you have my full support and I'd
> be happy to lend a hand.

I would expect also that some RT subgroups would be highly interested in
getting it to respect priority for reworking parts of softirq.

bill

