Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbUKRRFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbUKRRFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUKRRDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:03:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38665 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262767AbUKRRCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:02:44 -0500
Date: Thu, 18 Nov 2004 17:02:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: [patch] 2.6.10-rc2-mm2: MTD_XIP dependencies
Message-ID: <20041118170238.B11866@flint.arm.linux.org.uk>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
References: <20041118021538.5764d58c.akpm@osdl.org> <20041118154110.GE4943@stusta.de> <1100793112.8191.7315.camel@hades.cambridge.redhat.com> <Pine.LNX.4.61.0411181132440.12260@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0411181132440.12260@xanadu.home>; from nico@cam.org on Thu, Nov 18, 2004 at 11:34:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 11:34:56AM -0500, Nicolas Pitre wrote:
> On Thu, 18 Nov 2004, David Woodhouse wrote:
> 
> > On Thu, 2004-11-18 at 16:41 +0100, Adrian Bunk wrote:
> > > Let's put the dependencies from the #error into the Kconfig file:
> > 
> > Looks sane to me. Nico?
> 
> And why is the current arrangement actually a problem?

because it prevents building with, eg, make allyesconfig

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
