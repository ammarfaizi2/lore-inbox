Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUIKQpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUIKQpf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 12:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268174AbUIKQpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 12:45:35 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:57353 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268199AbUIKQp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 12:45:26 -0400
Date: Sat, 11 Sep 2004 17:45:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?iso-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
Message-ID: <20040911174516.A2956@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@linux.ie>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	=?iso-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
	DRI Devel <dri-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <9e47339104091008115b821912@mail.gmail.com> <1094829278.17801.18.camel@localhost.localdomain> <9e4733910409100937126dc0e7@mail.gmail.com> <1094832031.17883.1.camel@localhost.localdomain> <9e47339104091010221f03ec06@mail.gmail.com> <1094835846.17932.11.camel@localhost.localdomain> <9e47339104091011402e8341d0@mail.gmail.com> <Pine.LNX.4.58.0409102254250.13921@skynet> <20040911132727.A1783@infradead.org> <9e47339104091109111c46db54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9e47339104091109111c46db54@mail.gmail.com>; from jonsmirl@gmail.com on Sat, Sep 11, 2004 at 12:11:13PM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 12:11:13PM -0400, Jon Smirl wrote:
> The resource reservation conflicts are already solved in the current
> DRM code. Most of the changes are in kernel and the rest are in the
> pipeline.  DRM loads in two modes, primary where it behaves like a
> normal Linux driver and stealth where it uses the resources without
> telling the kernel. Stealth/primary mode is a transition tool until
> things get fixed. Once everything is sorted out stealth mode can be
> removed.

Not, it's not been solved.  You hacked around the most common symptoms.

