Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbUJZUeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUJZUeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbUJZUdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:33:44 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:12818 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261448AbUJZUdY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:33:24 -0400
Date: Wed, 27 Oct 2004 00:33:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <roland@topspin.com>
Cc: Tom Rini <trini@kernel.crashing.org>, sam@ravnborg.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/take 2] ppc: fix build with O=$(output_dir)
Message-ID: <20041026223351.GD30918@mars.ravnborg.org>
Mail-Followup-To: Roland Dreier <roland@topspin.com>,
	Tom Rini <trini@kernel.crashing.org>, sam@ravnborg.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <52is979pah.fsf@topspin.com> <20041019164449.GF6298@smtp.west.cox.net> <521xfua835.fsf_-_@topspin.com> <20041019182928.GA12544@smtp.west.cox.net> <52wtxm8ric.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52wtxm8ric.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:58:03AM -0700, Roland Dreier wrote:
>     Tom> This misses the bit to invoke the checker as well (when I
>     Tom> first thought this up I poked Al Viro about the general
>     Tom> question of checker on boot code, and he wanted it, so...).
>     Tom> And having 2 'magic' rules not just 1 is why I don't like
>     Tom> this too much and was hoping Sam would have some idea of a
>     Tom> good fix.
> 
> Hmm, good point, forgot about the checker.  I tried various magic ways
> of fixing this with vpath etc. but I couldn't mke it work.  Sam,
> you're our last hope I guess.

ppc seems to come pretty low in my todo list these days - sorry.
Will take a deep look one day.

[um, m232r needs a great deal of attention also..]

	Sam
