Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVCJRgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVCJRgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVCJRcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:32:47 -0500
Received: from inutil.org ([193.22.164.111]:60545 "EHLO
	vserver151.vserver151.serverflex.de") by vger.kernel.org with ESMTP
	id S262942AbVCJR1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:27:34 -0500
Date: Thu, 10 Mar 2005 18:27:24 +0100
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Average power consumption in S3?
Message-ID: <20050310172724.GA6211@informatik.uni-bremen.de>
References: <20050309142612.GA6049@informatik.uni-bremen.de> <E1D92Mk-0006HD-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D92Mk-0006HD-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.5.6+20040907i
From: Moritz Muehlenhoff <jmm@inutil.org>
X-SA-Exim-Connect-IP: 84.137.120.245
X-SA-Exim-Mail-From: jmm@inutil.org
X-SA-Exim-Scanned: No (on vserver151.vserver151.serverflex.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> Radeons don't actually power down in D3 unless some registers are set,
> and even then the kernel doesn't currently have any code that would put
> the Radeon in D3. If you're willing to test something, could you try the
> code at
> 
> http://www.srcf.ucam.org/~mjg59/radeon/
> 
> immediately before putting the machine into suspend? Make sure that you
> do this from something other than X.

This reduces power consumption from ca. 1500 to ca. 1200 mWh, so it's
already a huge improvement, but with 1.5 days of maximal suspend still
pretty far away from a week.

Cheers,
        Moritz
