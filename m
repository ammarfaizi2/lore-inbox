Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUBWW2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUBWW2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:28:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:923 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262076AbUBWW2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:28:13 -0500
Date: Mon, 23 Feb 2004 14:28:11 -0800
From: Chris Wright <chrisw@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, Willy Weisz <weisz@vcpc.univie.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Client looses NFS handle (kernel 2.6.3)
Message-ID: <20040223142811.I22989@build.pdx.osdl.net>
References: <20040221214345.6533eb68.akpm@osdl.org> <1077444724.2944.10.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1077444724.2944.10.camel@nidelv.trondhjem.org>; from trond.myklebust@fys.uio.no on Sun, Feb 22, 2004 at 02:12:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Trond Myklebust (trond.myklebust@fys.uio.no) wrote:
> The "Can't bind to reserved port" error message looks like the known
> problem when you set CONFIG_SECURITY. It has been discussed several
> times already on l-k.
> 
> Please either disable CONFIG_SECURITY (it's not as if *that* is going to
> be a showstopper when migrating to 2.6.x from 2.4.x) or go to my website
> and apply the advertised fix:
> 
> http://www.fys.uio.no/~trondmy/src/Linux-2.6.x/2.6.3/linux-2.6.3-08-reconnect.dif

Looks nice.  Will this go upstream, or is there still other issue?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
