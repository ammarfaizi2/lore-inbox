Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbUJaV6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUJaV6H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUJaV6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:58:07 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:19952 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261574AbUJaVx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:53:27 -0500
Date: Sun, 31 Oct 2004 14:53:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>, sam@ravnborg.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/take 2] ppc: fix build with O=$(output_dir)
Message-ID: <20041031215320.GM15699@smtp.west.cox.net>
References: <52is979pah.fsf@topspin.com> <20041019164449.GF6298@smtp.west.cox.net> <521xfua835.fsf_-_@topspin.com> <20041019182928.GA12544@smtp.west.cox.net> <20041031223949.GB21471@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031223949.GB21471@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 11:39:50PM +0100, Sam Ravnborg wrote:
> On Tue, Oct 19, 2004 at 11:29:28AM -0700, Tom Rini wrote:
>  
> > This misses the bit to invoke the checker as well (when I first thought
> > this up I poked Al Viro about the general question of checker on boot
> > code, and he wanted it, so...).  And having 2 'magic' rules not just 1
> > is why I don't like this too much and was hoping Sam would have some
> > idea of a good fix.
> 
> Hi Tom.
> 
> Finally took a look.
> The best approach is to grab a copy of the .c file and compile
> that in this dir.
> In this way we avoid unessesary recompile etc. but waste a bit disk space.
> I do not like symlinks in general and made a copy. (note: uses cat to give
> appropriate permission)
> 
> If you are OK with this let me know if you want me to push it to linus
> or you go via the ppc tree.

Works for me, and please push it via your tree.  Thanks &
Acked-by: Tom Rini <trini@kernel.crashing.org>

if wanted.

-- 
Tom Rini
http://gate.crashing.org/~trini/
