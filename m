Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUJOO2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUJOO2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267881AbUJOO2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:28:38 -0400
Received: from holomorphy.com ([207.189.100.168]:37770 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267869AbUJOO2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:28:34 -0400
Date: Fri, 15 Oct 2004 07:28:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@novell.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015142825.GI5607@holomorphy.com>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain> <1097846353.2674.13298.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097846353.2674.13298.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 09:19:13AM -0400, Albert Cahalan wrote:
> I display the data as a column in "top". Docomentation is
> much easier to deal with if it doesn't have lots of special
> cases for different kernel versions.
> I guess I'd prefer that the fields of Linux 2.4 be restored,
> and that any new fields be added on the end. Note that the
> text and data fields are supposed to be rss-like as well.
> Except for the size, they're all supposed to be that way.
> This data was created to match what BSD provides.
> If adding a new file to /proc, please pick a short name
> that is friendly toward tab completion. "phymem" is OK.

The overhead is too catastrophic to tolerate. Please work with us
to find a sufficient approximation to whatever statistics you want
opposed to reverting to 2.4 algorithms or ones of similar expense.


-- wli
