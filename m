Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUEJXMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUEJXMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUEJXM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:12:29 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:60845 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263037AbUEJXLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:11:55 -0400
Date: Mon, 10 May 2004 16:11:46 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040510231146.GA5168@taniwha.stupidest.org>
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510150203.3257ccac.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 03:02:03PM -0700, Andrew Morton wrote:

> Capabilities are broken and don't work.  Nobody has a clue how to
> provide the required services with SELinux and nobody has any code
> and we need the feature *now* before vendors go shipping even more
> ghastly stuff.

eh? magic groups are nasty...  and why is this needed?  can't
oracle/whatever just run with a wrapper to give the capabilities out
as required until a better solution is available

merging this as-is IMO is a mistake, how about we get a chance to chew
on this for a while --- superficially it feels like a really nasty
hack

and who cares if vendors show something worse?  vendors ship crap all
the time, that's partly why we have vendor kernels --- to ship crap
that people want now w/o having to corrupt and pollute the cleanliness
of the mainline kernel until a sufficiently well thought out sane plan
can be devised



  --cw
