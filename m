Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWCHLBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWCHLBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWCHLBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:01:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32724 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750879AbWCHLBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:01:16 -0500
Date: Wed, 8 Mar 2006 12:01:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Mittendorfer <delist@gmx.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SUSPEND] Screen slides down after STR / neomagic
Message-ID: <20060308110102.GH1710@elf.ucw.cz>
References: <20060306100905.0199e7b5.delist@gmx.net> <20060307214337.GA1777@elf.ucw.cz> <20060308004555.fe20b052.delist@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308004555.fe20b052.delist@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 08-03-06 00:45:55, Richard Mittendorfer wrote:
> Also sprach Pavel Machek <pavel@ucw.cz> (Tue, 7 Mar 2006 22:43:37
> +0100):
> > On Po 06-03-06 10:09:05, Richard Mittendorfer wrote:
> > > Hello,
> > > 
> > > Toshiba Libretto; Every time I suspend to RAM an come back to Console or
> > > later exit Xorg (it's ok within X), the screen is somewhat displaced
> > > downward:
> > 
> > Did you read Doc*/power/video.txt?
> 
> Oh, wasn't aware of this file. (Havn't looked there for a while now.)
> Now I know what went wrong. :-)
> 
> Finally the vbetool trick did it.

Could you

1) try to find out if acpi_sleep=* options can fix it too (they are
better for debugging)

2) submit patch for video.txt

3) if possible, download s2ram from www.sf.net/projects/suspend (from
CVS) and add your machine to whitelist?

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
