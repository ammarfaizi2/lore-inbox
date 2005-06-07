Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVFGBXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVFGBXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 21:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVFGBXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 21:23:05 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:6149 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261805AbVFGBXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 21:23:02 -0400
Date: Mon, 6 Jun 2005 20:40:38 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML binary
Message-ID: <20050607004038.GA12466@ccure.user-mode-linux.org>
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org> <200506070105.20422.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506070105.20422.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 01:05:19AM +0200, Blaisorblade wrote:
> NACK at all, definitely, don't apply this one please. This patch:
> 
> 1) On i386 does not fix the problem it was supposed to fix when I originately 
> sent the first version (i.e. avoiding to create a .thread_private section to 
> allow linking against NPTL glibc). It's done on x86_64 and forgot on i386.
> 2) Splitting the linker script for subarchs is definitely not needed.
> 3) This removes the fix (done through objcopy -G switcheroo) to a link time 
> conflict happening on some weird glibc combinations.
> 
> I'll merge this work when it's ready.

OK, Andrew, just drop this one for now.

				Jeff
