Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbSI0Qye>; Fri, 27 Sep 2002 12:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSI0Qyd>; Fri, 27 Sep 2002 12:54:33 -0400
Received: from ns.suse.de ([213.95.15.193]:3591 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261608AbSI0Qyd>;
	Fri, 27 Sep 2002 12:54:33 -0400
Date: Fri, 27 Sep 2002 18:59:49 +0200
From: Andi Kleen <ak@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Put modules into linear mapping
Message-ID: <20020927185949.A27271@wotan.suse.de>
References: <20020927181445.A9595@wotan.suse.de> <Pine.LNX.4.44.0209271849180.338-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209271849180.338-100000@serv>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 06:52:28PM +0200, Roman Zippel wrote:
> > > If it's supposed to be a generic function, it makes sense, otherwise we
> > > could just put it into module.c.
> >
> > Ok, I will change it.
> 
> Any chance to use __HAVE_MODULE_MAP, so every arch (except sparc64/x86-64)
> can automatically benefit from this?

I can put it in asm-generic/

But people have to check themselves if the vmalloc trick works for them.

-Andi

