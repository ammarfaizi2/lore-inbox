Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265181AbUGIVQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUGIVQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUGIVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:16:13 -0400
Received: from [213.146.154.40] ([213.146.154.40]:30897 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265181AbUGIVQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:16:10 -0400
Date: Fri, 9 Jul 2004 22:16:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix building on Solaris (and don't break Cygwin)
Message-ID: <20040709211605.GA6126@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040709210011.GG28002@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709210011.GG28002@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 02:00:11PM -0700, Tom Rini wrote:
> The following is from Jean-Christophe Dubois <jdubois@mc.com>.  On
> Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.  However,
> on cygwin (the other odd place that the kernel is compiled on)
> <inttypes.h> doesn't exist.  So we end up with something like the
> following.
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Yikes.  <stdint.h> is mandated by C99, please complain to sun instead or
write up the header yourself - it's not that difficult anyway.

