Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUGLRox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUGLRox (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUGLRox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:44:53 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:11242 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S265226AbUGLRow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:44:52 -0400
Date: Mon, 12 Jul 2004 10:44:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix building on Solaris (and don't break Cygwin)
Message-ID: <20040712174450.GA16877@smtp.west.cox.net>
References: <20040709210011.GG28002@smtp.west.cox.net> <20040709211605.GA6126@infradead.org> <ccs7c2$bef$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccs7c2$bef$1@terminus.zytor.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 08:19:14PM +0000, H. Peter Anvin wrote:
> Followup to:  <20040709211605.GA6126@infradead.org>
> By author:    Christoph Hellwig <hch@infradead.org>
> In newsgroup: linux.dev.kernel
> >
> > On Fri, Jul 09, 2004 at 02:00:11PM -0700, Tom Rini wrote:
> > > The following is from Jean-Christophe Dubois <jdubois@mc.com>.  On
> > > Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.  However,
> > > on cygwin (the other odd place that the kernel is compiled on)
> > > <inttypes.h> doesn't exist.  So we end up with something like the
> > > following.
> > > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> > 
> > Yikes.  <stdint.h> is mandated by C99, please complain to sun instead or
> > write up the header yourself - it's not that difficult anyway.
> > 
> 
> <inttypes.h> is also mandated by C99, and is a more complete header
> (it includes stdint.h).

Which makes it quite annoying that Cygwin lacks it.

-- 
Tom Rini
http://gate.crashing.org/~trini/
