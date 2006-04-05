Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWDELAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWDELAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 07:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWDELAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 07:00:10 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:46855 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751213AbWDELAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 07:00:08 -0400
Date: Wed, 5 Apr 2006 13:00:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, akpm@osdl.org
Subject: Re: [PATCH] Fix sed regexp to generate asm-offset.h
Message-ID: <20060405110002.GA22508@mars.ravnborg.org>
References: <20060328.001854.93020330.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328.001854.93020330.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 12:18:54AM +0900, Atsushi Nemoto wrote:
> Changes to Makefile.kbuild ("kbuild: add -fverbose-asm to i386
> Makefile") breaks asm-offset.h file on MIPS.  Other archs possibly
> suffer this change too but I'm not sure.
> 
> Here is a fix just for MIPS.  
Thanks, applied to the kbuild bugfix tree.

	Sam
