Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUIKM1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUIKM1m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 08:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUIKM1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 08:27:42 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:53513 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268131AbUIKM1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 08:27:41 -0400
Date: Sat, 11 Sep 2004 13:27:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?iso-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
Message-ID: <20040911132727.A1783@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	=?iso-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
	DRI Devel <dri-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <9e47339104090919015b5b5a4d@mail.gmail.com> <20040910153135.4310c13a.felix@trabant> <9e47339104091008115b821912@mail.gmail.com> <1094829278.17801.18.camel@localhost.localdomain> <9e4733910409100937126dc0e7@mail.gmail.com> <1094832031.17883.1.camel@localhost.localdomain> <9e47339104091010221f03ec06@mail.gmail.com> <1094835846.17932.11.camel@localhost.localdomain> <9e47339104091011402e8341d0@mail.gmail.com> <Pine.LNX.4.58.0409102254250.13921@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409102254250.13921@skynet>; from airlied@linux.ie on Fri, Sep 10, 2004 at 11:19:42PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the kernel developers can address this point I would be most
> interested, in fact I don't want to hear any more about sharing lowlevel
> VGA device drivers until someone addresses why it is acceptable to have
> two separate driver driving the same hardware for video and not for
> anything else.. (remembering graphics cards are not-multifunction cards -
> like Christoph used as an example before - 2d/3d are not separate
> functions...)...

Well, Alan's proposal gets things back into a working shape with both
fbdev and get additional benefits like hotplug and autloading without
a major revamp of everything.  The major rework will have to happen sooner
or later anyway, but by fixing the obvious problems we face now first it
can be done in small pieces and with far less pressure.
