Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWFXVx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWFXVx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 17:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWFXVx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 17:53:29 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:25764 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964846AbWFXVx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 17:53:27 -0400
Date: Sat, 24 Jun 2006 23:52:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masatake YAMATO <jet@gyve.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adding symbols in Kconfig and defconfig to TAGS
Message-ID: <20060624215249.GB8904@mars.ravnborg.org>
References: <20060622.122120.261356707.yamato@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622.122120.261356707.yamato@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 12:21:20PM +0900, Masatake YAMATO wrote:
> I'm using TAGS generated from "make TAGS" to read the kernel source code.
> 
> When I met a ifdef block
> 
> 	  #ifdef CONFIG_FOO
> 	  	 ...
> 	  #endif
> 
> in the soruce code I would like to know the meaning CONFIG_FOO
> to decide whether I should read inside the ifdef block
> or not. meaning CONFIG_FOO is well documented in Kconfig.
> So it is nice if I can jump to CONFIG_FOO entry in Kconfig
> from "#ifdef CONFIG_FOO" with the tag jump.
> 
> Here is the patch to add symbols in Kconfig and defconfig to TAGS
> in "make TAGS" operation.

Applied after fixing 80 coloumn breakage.

	Sam
