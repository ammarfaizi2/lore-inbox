Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269848AbUIDJ33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269848AbUIDJ33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269849AbUIDJ33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:29:29 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:60933 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269848AbUIDJ3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:29:20 -0400
Date: Sat, 4 Sep 2004 10:29:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sf.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904102914.B13149@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409040145240.25475@skynet>; from airlied@linux.ie on Sat, Sep 04, 2004 at 01:51:24AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 01:51:24AM +0100, Dave Airlie wrote:
> >
> > Then drm_core would always be bundled with the OS.
> >
> > Is there any real advantage to spliting core/library and creating three
> > interface compatibily problems?
> 
> Yes we only have one binary interface, between the core and module, this
> interface is minimal, so AGP won't go in it... *ALL* the core does is deal
> with the addition/removal of modules, the idea being that the interface is
> very minor and new features won't change it...

Umm, the Linux kernel isn't about minimizing interfaces.  We don't link a
copy of scsi helpers into each scsi driver either, or libata into each sata
driver.

