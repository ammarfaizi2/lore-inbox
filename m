Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUBTXDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUBTXDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:03:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27831 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261419AbUBTXD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:03:29 -0500
From: Daniel Phillips <phillips@arcor.de>
To: paulmck@us.ibm.com
Subject: Re: Non-GPL export of invalidate_mmap_range
Date: Fri, 20 Feb 2004 18:00:32 -0500
User-Agent: KMail/1.5.4
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
References: <20040216190927.GA2969@us.ibm.com> <200402201535.47848.phillips@arcor.de> <20040220140116.GD1269@us.ibm.com>
In-Reply-To: <20040220140116.GD1269@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402201800.12077.phillips@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 February 2004 09:01, Paul E. McKenney wrote:
> On Fri, Feb 20, 2004 at 03:37:26PM -0500, Daniel Phillips wrote:
> > Actually, I erred there in that invalidate_mmap_range should not export
> > the flag, because it never makes sense to pass in non-zero from a DFS.
>
> Doesn't vmtruncate() want to pass non-zero "all" in to
> invalidate_mmap_range() in order to maintain compatibility with existing
> Linux semantics?

That comes from inside.  The DFS's truncate interface should just be 
vmtruncate.  If I missed something, please shout.

Regards,

Daniel

