Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVBAFnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVBAFnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 00:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVBAFnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 00:43:41 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:29549 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261563AbVBAFnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 00:43:40 -0500
Date: Tue, 1 Feb 2005 06:45:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] ppc64: Implement a vDSO and use it for signal trampoline #2
Message-ID: <20050201054547.GB8136@mars.ravnborg.org>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
References: <1107222584.5906.43.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107222584.5906.43.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 12:49:44PM +1100, Benjamin Herrenschmidt wrote:
  core-y				+= arch/ppc64/kernel/
> +core-y				+= arch/ppc64/kernel/vdso32/
> +core-y				+= arch/ppc64/kernel/vdso64/

Please include your previous change to reflect this in
arch/ppc64/kernel/Makefile
It is much more obvious to look up this in the Makefile like we do for
the rest of the kernel.

	Sam
