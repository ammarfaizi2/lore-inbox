Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268338AbUHQQlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268338AbUHQQlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268339AbUHQQlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:41:02 -0400
Received: from gprs214-122.eurotel.cz ([160.218.214.122]:33152 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268338AbUHQQk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:40:58 -0400
Date: Tue, 17 Aug 2004 18:40:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Coding style: do_this(a,b) vs. do_this(a, b)
Message-ID: <20040817164046.GA19009@elf.ucw.cz>
References: <1092743463.5759.1403.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092743463.5759.1403.camel@cube>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Coding style document is not consistent with
> > itself on whether there should be space after
> > ","... This makes it standartize on ", " option.
> 
> You can read it both ways, right? It's easy.
> I can't even see the difference unless I'm
> looking for it.

Well, you maybe can't tell the difference, but I definitely can. You
can read code aligned by two spaces, right?

> We don't need any more bureaucracy.
> 
> do_this(a,b); (1)
> do_this(a, b); (2)
> do_this (a,b);

This looks extremely bad.

> do_this (a, b);
> 
> I can read them all. I might notice the space in
> front of the '(', but I might not. Even putting a
> space in front of the ';' isn't unreadable.
> 
> People will pass laws until they are choked off,
> unable to move without being in violation of some
> silly little thing.

I've seen people "fixing" code from (2) to (1), because they thought I
prefer (1). (And I definitely don't). So yes, it is important.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
