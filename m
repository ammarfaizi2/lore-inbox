Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274764AbRIUGAV>; Fri, 21 Sep 2001 02:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274765AbRIUGAL>; Fri, 21 Sep 2001 02:00:11 -0400
Received: from ns.caldera.de ([212.34.180.1]:3026 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S274764AbRIUF7w>;
	Fri, 21 Sep 2001 01:59:52 -0400
Date: Fri, 21 Sep 2001 07:58:54 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Steve Lord <lord@sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gonyou, Austin" <austin@coremetrics.com>,
        narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: XFS to main kernel source
Message-ID: <20010921075854.A11617@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, Steve Lord <lord@sgi.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Gonyou, Austin" <austin@coremetrics.com>,
	narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <hch@ns.caldera.de> <200109202131.f8KLVbB19795@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109202131.f8KLVbB19795@jen.americas.sgi.com>; from lord@sgi.com on Thu, Sep 20, 2001 at 04:31:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 04:31:37PM -0500, Steve Lord wrote:
> >  o The whole vnode layer
> 
> Two answers here - economics and code stability. This is a filesystem
> which has been worked on by people being payed to do so by a corporation,
> therefore there is a budget (long since blown). It was simpler and hence
> cheaper to wrap XFS in a conversion layer than to rework the code down
> into the bowels of the filesystem. Then the stability part of it, we
> started with a working filesystem, from an engineering standpoint it 
> made more sense to keep as much of the existing code base intact as
> possible - the less surgery performed the better in terms of keeping
> things running, and making it easy to take enhancements and fixes made
> in the Irix base into the Linux code (we don't do it the other way around).

I completly understand SGI's reson to do this - but yet I don't want to
see such code in the mainline for obvios reasons..

> >  o the hooks for a propritary clusterfs..
> 
> Well we have to make money on something you know.... and in reality
> there are not a lot of them in the filesystem.

Again I understand SGI's reasoning - but such hooks are usually not
considered to be a good thing line.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
