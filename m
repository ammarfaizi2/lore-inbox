Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318861AbSHWP5d>; Fri, 23 Aug 2002 11:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318866AbSHWP5d>; Fri, 23 Aug 2002 11:57:33 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:17156 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318861AbSHWP5c>; Fri, 23 Aug 2002 11:57:32 -0400
Date: Fri, 23 Aug 2002 17:01:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Federico Di Gregorio <fog@initd.org>, faith@valinux.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel 830m backport (2.5 -> 2.4)
Message-ID: <20020823170132.A21711@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Federico Di Gregorio <fog@initd.org>, faith@valinux.com,
	linux-kernel@vger.kernel.org
References: <1030109549.1120.86.camel@momo> <20020823153057.A18848@infradead.org> <1030116185.5911.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030116185.5911.17.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Aug 23, 2002 at 04:23:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 04:23:05PM +0100, Alan Cox wrote:
> On Fri, 2002-08-23 at 15:30, Christoph Hellwig wrote:
> 
> > Alan, is there any chance you could send marcelo the -ac drm code?
> 
> It needs untangling from any rmap macro dependancies. Go ahead 

There are no -rmap depencies, just on a few -ac features (new scheduler,
strict overcommit).

I've uploaded a patch that updates the mainline drm code to -ac, fixes
all compiler warnings and removes the remaining LINUX_VERSION_CODE checks
after most have already been removed in -ac.

It's at http://verein.lst.de/~hch/misc/linux-2.4.20-pre4-drm.patch
