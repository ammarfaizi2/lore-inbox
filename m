Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267934AbTBLXll>; Wed, 12 Feb 2003 18:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267938AbTBLXll>; Wed, 12 Feb 2003 18:41:41 -0500
Received: from tapu.f00f.org ([202.49.232.129]:61376 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267934AbTBLXlk>;
	Wed, 12 Feb 2003 18:41:40 -0500
Date: Wed, 12 Feb 2003 15:51:30 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT foolish question
Message-ID: <20030212235130.GA13629@f00f.org>
References: <1045084764.4767.76.camel@urca.rutgers.edu> <20030212140338.6027fd94.akpm@digeo.com> <1045088991.4767.85.camel@urca.rutgers.edu> <20030212224226.GA13129@f00f.org> <1045090977.21195.87.camel@urca.rutgers.edu> <20030212232443.GA13339@f00f.org> <1045092802.4766.96.camel@urca.rutgers.edu> <20030212233846.GA13540@f00f.org> <1045093775.21195.99.camel@urca.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045093775.21195.99.camel@urca.rutgers.edu>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 06:49:35PM -0500, Bruno Diniz de Paula wrote:

> What is your partition type? ext2?

XFS.

I can't test e2fs right now as my test machine is running 2.5.60 where
it fails just as it does for you.  I think both use generic_direct_IO
or whatever it's called so maybe I'll have a poke in there as to why
2.5.x is failing.



  --cw
