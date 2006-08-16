Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWHPSdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWHPSdu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWHPSdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:33:50 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:34260 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932182AbWHPSdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:33:49 -0400
Date: Wed, 16 Aug 2006 20:33:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 -- new depancy on curses development
Message-ID: <20060816183348.GA5852@mars.ravnborg.org>
References: <20060813012454.f1d52189.akpm@osdl.org> <44E2E867.2050508@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E2E867.2050508@shadowen.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 10:41:59AM +0100, Andy Whitcroft wrote:
> Andrew Morton wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 
> > git-lxdialog.patch
> 
> This tree seems to change the Makefile dependancies in the kconfig 
> subdirectory such that a plain compile of the kernel leads to an attempt 
> to build the menuconfig targets.  This in turn adds a new dependancy on 
> the curses development libraries.
What I see is that "make defconfig" builds _all_ *config targets -
strange...

Hmmm, why does git pick up my hostname (mars)? Have I configured
somethign wrong (not in git but my gentoo system)?

	Sam
