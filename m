Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUG1Qlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUG1Qlc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUG1Qlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:41:32 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:23957 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S267283AbUG1QjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:39:17 -0400
Date: Wed, 28 Jul 2004 09:39:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix zlib debug in ppc boot header
Message-ID: <20040728163914.GQ10891@smtp.west.cox.net>
References: <20040728112222.GA7670@suse.de> <20040728152938.GM10891@smtp.west.cox.net> <20040728174213.GA7226@mars.ravnborg.org> <20040728155643.GO10891@smtp.west.cox.net> <20040728181817.GA14737@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728181817.GA14737@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 08:18:17PM +0200, Sam Ravnborg wrote:

> On Wed, Jul 28, 2004 at 08:56:43AM -0700, Tom Rini wrote:
> > > 
> > > It should be possible just to include the zlib_deflate.o file from lib/.
> > > At least oprofile plays suchs ugly tricks.
> > 
> > Can you think of a cleaner way to do this?
> No, otherwise I would have changed oprofile also.

And, er, too early but I of course ment zlib_inflate, since we have the
compressed image we need to uncompress..

-- 
Tom Rini
http://gate.crashing.org/~trini/
