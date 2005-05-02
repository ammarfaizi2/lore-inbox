Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVEBRYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVEBRYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVEBRXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:23:22 -0400
Received: from mail.autoweb.net ([198.172.237.26]:57997 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261365AbVEBRUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:20:38 -0400
Date: Mon, 2 May 2005 13:20:12 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@suse.de>,
       Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050502172012.GD11726@mythryan2.michonline.com>
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com> <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 09:31:06AM -0700, Linus Torvalds wrote:
> That said, I think the /usr/bin/env trick is stupid too. It may be more 
> portable for various Linux distributions, but if you want _true_ 
> portability, you use /bin/sh, and you do something like
> 
> 	#!/bin/sh
> 	exec perl perlscript.pl "$@"
		if 0;

You don't really want Perl to get itself into an exec loop.

-- 

Ryan Anderson
  sometimes Pug Majere
