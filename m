Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267047AbSKWPyO>; Sat, 23 Nov 2002 10:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbSKWPyO>; Sat, 23 Nov 2002 10:54:14 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:21469 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S267047AbSKWPyO>;
	Sat, 23 Nov 2002 10:54:14 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
References: <200211220122.gAM1MQY305783@saturn.cs.uml.edu>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 22 Nov 2002 22:31:06 +0100
In-Reply-To: <200211220122.gAM1MQY305783@saturn.cs.uml.edu>
Message-ID: <m3n0o1gulh.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> Forget the shred program. It's less useful than having the
> filesystem simply zero the blocks, because it's slow and you
> can't be sure to hit the OS-visible blocks. Aside from encryption,
> the useful options are:
> 
> 1. plain old rm  (protect from users)
> 2. filesystem clears the blocks  (protect from root/kernel)

It won't protect you from the root. If you need protection from root,
be a root on your own machine. And be sure your unencrypted data, keys
etc. never make it to/through any hostile system.
-- 
Krzysztof Halasa
Network Administrator
