Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267311AbUHDPsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUHDPsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUHDPsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:48:23 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:12681 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S267311AbUHDPsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:48:20 -0400
Date: Wed, 4 Aug 2004 08:48:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Zink, Dan" <dan.zink@hp.com>
Cc: akpm@osdl.org, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: fix mktree utility in 64-bit cross-compile environment
Message-ID: <20040804154818.GL9235@smtp.west.cox.net>
References: <8C91B010B3B7994C88A266E1A72184D306BEFD8F@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8C91B010B3B7994C88A266E1A72184D306BEFD8F@cceexc19.americas.cpqcorp.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 05:01:05PM -0500, Zink, Dan wrote:

> The mktree utility is using "unsigned long" in the definition of a boot
> block structure.  This is bad when cross compiling from a 64-bit
> architecture...

<asm/types.h> isn't portable.  This program needs to still compile &
work on Cygwin & Solaris.

-- 
Tom Rini
http://gate.crashing.org/~trini/
