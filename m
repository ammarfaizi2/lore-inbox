Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267293AbUG1QYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267293AbUG1QYv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUG1QYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:24:50 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:30505 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267293AbUG1QRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:17:00 -0400
Date: Wed, 28 Jul 2004 20:18:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix zlib debug in ppc boot header
Message-ID: <20040728181817.GA14737@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
References: <20040728112222.GA7670@suse.de> <20040728152938.GM10891@smtp.west.cox.net> <20040728174213.GA7226@mars.ravnborg.org> <20040728155643.GO10891@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728155643.GO10891@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 08:56:43AM -0700, Tom Rini wrote:
> > 
> > It should be possible just to include the zlib_deflate.o file from lib/.
> > At least oprofile plays suchs ugly tricks.
> 
> Can you think of a cleaner way to do this?
No, otherwise I would have changed oprofile also.

I have not tried it out on ppc/boot stuff, but I so no reason
why it should not work out.

	Sam
