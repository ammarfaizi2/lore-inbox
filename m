Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbTEWQGd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 12:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264092AbTEWQGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 12:06:33 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:30090 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S264091AbTEWQGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 12:06:33 -0400
Date: Fri, 23 May 2003 17:21:53 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, <phillips@arcor.de>, <hch@infradead.org>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Avoid vmtruncate/mmap-page-fault race
In-Reply-To: <20030523073500.A1549@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0305231713230.1602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Paul E. McKenney wrote:
> On Tue, May 20, 2003 at 01:11:57AM -0700, Andrew Morton wrote:
> > 
> > However there is not a lot of commonality between the various nopage()s and
> > there may not be a lot to be gained from all this.  There is subtle code in
> > there and it is performance-critical.  I'd be inclined to try to minimise
> > overall code churn in this work.
> 
> Good point!  Here is a patch to do this.  A "few" caveats:

Sorry, I miss the point of this patch entirely.  At the moment it just
looks like an unattractive rearrangement - the code churn akpm advised
against - with no bearing on that vmtruncate race.  Please correct me.

Hugh

