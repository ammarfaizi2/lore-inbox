Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270804AbTHKAhK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 20:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270814AbTHKAhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 20:37:10 -0400
Received: from rj.SGI.COM ([192.82.208.96]:27828 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S270804AbTHKAgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 20:36:47 -0400
Date: Mon, 11 Aug 2003 10:34:14 +1000
From: Nathan Scott <nathans@sgi.com>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.5/2.6] buffer layer error at fs/buffer.c:2800 when unlinking
Message-ID: <20030811003413.GD9384@frodo>
References: <20030803145113.GA31715@hell.org.pl> <20030806235908.GC854@frodo> <20030810221640.GA14257@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810221640.GA14257@hell.org.pl>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:16:40AM +0200, Karol Kozimor wrote:
> Thus wrote Nathan Scott:
> > This is indeed an XFS issue (thanks for reporting it), the
> > patch below fixes it.
> 
> Thanks, it works fine now. I've still got one issue with XFS (this: [1] may
> be helpful) left, though I didn't manage yet to reproduce it under
> 2.6.0-test3 (though I've seen it with 2.6.0-test2, even with the above
> patch applied), so I'll start bothering you when (if, hopefully) this
> happens. Thanks again,
> 
> [1] http://marc.theaimsgroup.com/?l=linux-xfs&m=105240964125502&w=2
>     (I reported this once or twice on linux-xfs, however unsuccessfully)

A random corruption problem was fixed in test3 also, that may
well be what this issue is.  Let us know if you see it again.

thanks.

-- 
Nathan
