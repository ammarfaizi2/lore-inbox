Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUJOOrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUJOOrp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUJOOro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:47:44 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:10705 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267903AbUJOOrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:47:36 -0400
Subject: Re: per-process shared information
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@novell.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
In-Reply-To: <20041015142825.GI5607@holomorphy.com>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain>
	 <1097846353.2674.13298.camel@cube>  <20041015142825.GI5607@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1097851258.2666.13421.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Oct 2004 10:40:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 10:28, William Lee Irwin III wrote:
> On Fri, Oct 15, 2004 at 09:19:13AM -0400, Albert Cahalan wrote:
> > I display the data as a column in "top". Docomentation is
> > much easier to deal with if it doesn't have lots of special
> > cases for different kernel versions.
> > I guess I'd prefer that the fields of Linux 2.4 be restored,
> > and that any new fields be added on the end. Note that the
> > text and data fields are supposed to be rss-like as well.
> > Except for the size, they're all supposed to be that way.
> > This data was created to match what BSD provides.
> > If adding a new file to /proc, please pick a short name
> > that is friendly toward tab completion. "phymem" is OK.
> 
> The overhead is too catastrophic to tolerate. Please work with us
> to find a sufficient approximation to whatever statistics you want
> opposed to reverting to 2.4 algorithms or ones of similar expense.

Why not get rid of rss too then? It's overhead.



