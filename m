Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269873AbUIDKZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269873AbUIDKZx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269874AbUIDKZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:25:53 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:2822 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269873AbUIDKZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:25:45 -0400
Date: Sat, 4 Sep 2004 11:25:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904112535.A13750@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <413997A7.9060406@tungstengraphics.com>; from keith@tungstengraphics.com on Sat, Sep 04, 2004 at 11:23:35AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 11:23:35AM +0100, Keith Whitwell wrote:
> > Actually regulat users do.  And they do by pulling an uptodate kernel or
> > using a vendor kernel with backports.  This model would work for video drivers
> > aswell.
> 
> Sure, explain to me how I should upgrade my RH-9 system to work on my new i915?

Download a new kernel.org kernel or petition the fedora legacy folks to
include a drm update.  The last release RH-9 kernel has various security
and data integrity issues anyway, so you'd be a fool to keep running it.

> However, introducing a new binary interface isn't going to magically transform 
> a fairly neglected codebase into a sparkly new one.  All I can really see it 
> doing is saving a few K of memory in the hetrogenous dual head case.  Oh, and 
> introducing a new failure mode to be debugged at a distance.

huh?  it you change the ABI your modules simply won't load.  that's not
exactly what I'd call debugging.

