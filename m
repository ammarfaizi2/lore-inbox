Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbTBJJKF>; Mon, 10 Feb 2003 04:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbTBJJKE>; Mon, 10 Feb 2003 04:10:04 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:19604 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264815AbTBJJKC>; Mon, 10 Feb 2003 04:10:02 -0500
Date: Mon, 10 Feb 2003 10:19:19 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Neil Booth <neil@daikokuya.co.uk>, Jeff Muizelaar <muizelaar@rogers.com>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030210091919.GE11562@louise.pinerecords.com>
References: <1044385759.1861.46.camel@localhost.localdomain.suse.lists.linux.kernel> <200302041935.h14JZ69G002675@darkstar.example.net.suse.lists.linux.kernel> <b1pbt8$2ll$1@penguin.transmeta.com.suse.lists.linux.kernel> <p73znpbpuq3.fsf@oldwotan.suse.de> <3E4045D1.4010704@rogers.com> <20030206070256.GB30345@daikokuya.co.uk> <3E470AFC.4070906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E470AFC.4070906@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [jgarzik@pobox.com]
> 
> Given the existing TinyCC source base, function inlining is a big step 
> (since tcc doesn't do AST-like things currently), so don't expect that 
> very soon.  TinyCC is a fun little project to watch and play around 
> with, though, and can compile most major open source projects, as well 
> as itself.

I wonder how that can be, though, because I've failed getting it to
compile code as trivial as

	walk_de = (dirent_t *) debug_malloc(sizeof(dirent_t));

where dirent_t is a simple structure and debug_malloc is prototyped
to void *debug_malloc(size_t size);

-- 
Tomas Szepe <szepe@pinerecords.com>
