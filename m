Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265959AbUFTVwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUFTVwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUFTVwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:52:25 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:10901 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265959AbUFTVwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:52:02 -0400
Date: Mon, 21 Jun 2004 00:03:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 0/2] kbuild updates
Message-ID: <20040620220319.GA10407@mars.ravnborg.org>
Mail-Followup-To: Martin Schlemmer <azarah@nosferatu.za.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai Germaschewski <kai@germaschewski.name>
References: <20040620211905.GA10189@mars.ravnborg.org> <1087767034.14794.42.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087767034.14794.42.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 11:30:34PM +0200, Martin Schlemmer wrote:
> 
> I know Sam's mta blocks my mail at least (lame isp), but for the rest,
> please reconsider using this.
Hmm, got your mail.

> Many external modules, libs, etc use
> /lib/modules/`uname -r`/build to locate the _source_, and this will
> break them all.
Examples please. What I have seen so far is modules that was not
adapted to use kbuild when being build.
If they fail to do so they are inherently broken.

If I get just one good example I will go for the object directory, but
what I have seen so far is whining - no examples.

	Sam
