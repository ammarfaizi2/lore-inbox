Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWASQe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWASQe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWASQe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:34:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:47877 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161150AbWASQe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:34:56 -0500
Date: Thu, 19 Jan 2006 17:34:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, starvik@axis.com, dev-etrax@axis.com,
       linux-kernel@vger.kernel.org
Subject: Re: cris: asm-offsets related build failure
Message-ID: <20060119163433.GA12724@mars.ravnborg.org>
References: <20060119001852.GO19398@stusta.de> <20060119085730.GP27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119085730.GP27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 08:57:30AM +0000, Al Viro wrote:
> On Thu, Jan 19, 2006 at 01:18:52AM +0100, Adrian Bunk wrote:
> > Hi Sam,
> > 
> > the following build failure is present on the cris architecture:
> > 
> > <--  snip  -->
> > 
> > ...
> > make[1]: *** No rule to make target `arch/cris/kernel/asm-offsets.c', 
> > needed by `arch/cris/kernel/asm-offsets.s'.  Stop.
> > make: *** [prepare0] Error 2
> 
> Subject: [PATCH] fix a typo in arch/cris/Makefile
> 
> fallout from "kbuild: cris use generic asm-offsets.h support" - symlink
> target was wrong
Hi Al.

Can I have a Signed-off-by: ... patch
or do you submit it yourself?

	Sam
