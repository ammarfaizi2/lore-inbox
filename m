Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266575AbUBQWYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUBQWXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:23:49 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:57748 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S266575AbUBQWWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:22:20 -0500
Date: Tue, 17 Feb 2004 23:22:18 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040217222218.GF2125@khan.acc.umu.se>
Mail-Followup-To: "Paul E. McKenney" <paulmck@us.ibm.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040216190927.GA2969@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216190927.GA2969@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 11:09:27AM -0800, Paul E. McKenney wrote:
> Hello, Andrew,
> 
> The attached patch to make invalidate_mmap_range() non-GPL exported
> seems to have been lost somewhere between 2.6.1-mm4 and 2.6.1-mm5.
> It still applies cleanly.  Could you please take it up again?
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> 
> 
> It was EXPORT_SYMBOL_GPL(), however IBM's GPFS is not GPL.

Ahhh, but it would be really nice if it was, even if it's irksome to get
decent performance out of it ;-)

[snip]


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
