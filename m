Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUIDMz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUIDMz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUIDMz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:55:57 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:12908 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267829AbUIDMz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:55:56 -0400
Date: Sat, 4 Sep 2004 14:58:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904125838.GA8318@mars.ravnborg.org>
Mail-Followup-To: Dave Airlie <airlied@linux.ie>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <41399CA2.3080607@yahoo.com.au> <Pine.LNX.4.58.0409041151200.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409041151200.25475@skynet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 11:54:06AM +0100, Dave Airlie wrote:
> >
> > Just out of interest, what would the scenario be if you do if you could
> > get a compatible driver?
> 
> you just grab a DRI snapshot which contains new userspace and DRM, and
> install it... it builds the DRM against your current kernel, now if your
> current kernel has a DRM module built-in which is a different version, you
> are screwed, snapshot process breaks..

So they are just building an external driver for the kernel.
No binary compatibility - and maybe a thin compat layer.
Not a big deal to maintain - only a small diff to latest kernel tree.

	Sam
