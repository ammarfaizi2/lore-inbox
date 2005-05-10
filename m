Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVEJUyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVEJUyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVEJUxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:53:53 -0400
Received: from mail.dif.dk ([193.138.115.101]:23427 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261311AbVEJUu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:50:57 -0400
Date: Tue, 10 May 2005 22:54:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Andrew Morton <akpm@osdl.org>,
       blaisorblade@yahoo.it, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/6] uml: remove elf.h [ compile-fix,
 for 2.6.12 ]
In-Reply-To: <20050510204048.GX3590@stusta.de>
Message-ID: <Pine.LNX.4.62.0505102251060.2386@dragon.hyggekrogen.localhost>
References: <20050509224509.0C105416E4@zion> <20050509183401.28082cbc.akpm@osdl.org>
 <Pine.LNX.4.61.0505101525360.16461@filer.marasystems.com>
 <20050510204048.GX3590@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005, Adrian Bunk wrote:

> On Tue, May 10, 2005 at 03:37:33PM +0200, Henrik Nordstrom wrote:
> >...
> > The /dev/null trick only works well for adding files, not removing them.
> 
> It works fine for removing files except when they have a zero length.
> 
Then a two-patch approach would seem to work as a hack. First patch just 
adds a blank line to the file making in non-zero length, second patch then 
uses the /dev/null trick to kill the file. A hack? Yes, certainly, but it 
sounds like it would work (actually, it does work, just tried it).


-- 
Jesper Juhl

