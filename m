Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUCOSC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUCOSCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:02:25 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:20308 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262648AbUCOSCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:02:17 -0500
Date: Mon, 15 Mar 2004 19:02:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] out-of-tree builds
Message-ID: <20040315180243.GB8456@mars.ravnborg.org>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai Germaschewski <kai@germaschewski.name>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.58.0403141353470.1231@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403141353470.1231@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 01:58:36PM +0100, Geert Uytterhoeven wrote:
> 
> Although I like the feature to build a kernel in a different directory a lot, I
> don't like its syntax. I prefer to just have a build directory where I can run
> `make whatever'.
> 
> The following patch adds a configure script to the kernel. If you run
> 
>     /path/to/kernel/source/tree/configure
> 
> it will create a Makefile in the current directory, after which you can just do
> `make whatever', just like in the source directory.
> 
> The configure script contains a simple protection for when run in the source
> directory, but this may be approved (I'm not a configure script guru).
> 
> Comments?

I like the general idea.
I'm in doubt that configure is the best name, because no actual
configuration takes place.

But I want to finish the external modules stuff before introducing
more features. So it will wait until then.

	Sam
