Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbTEMHWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTEMHWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:22:07 -0400
Received: from dp.samba.org ([66.70.73.150]:24205 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263348AbTEMHWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:22:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't build IDE as modules in BK 2.5.69 
In-reply-to: Your message of "Tue, 13 May 2003 13:44:12 +1000."
             <16064.27148.819310.962984@wombat.chubb.wattle.id.au> 
Date: Tue, 13 May 2003 15:45:41 +1000
Message-Id: <20030513073452.F3CC62C468@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <16064.27148.819310.962984@wombat.chubb.wattle.id.au> you write:
> 
> With the 2.5 bk linux as of 2003.05.13, and config options below,
> modutils seems to go into a seemingly infinite loop when trying to
> buld modules.dep on the resulting module set (and creates an extremely
> large modules.dep file -- 95M before the filesystem filled up)

OK, reproduced here.  I've simplified the depmod loop detection logic:
I was trying to be too clever.  

I've just released 0.9.12, which won't help your IDE problem, but will
terminate 8)

http://www.kernel.org/pub/linux/people/rusty/modules/module-init-tools-testsuite-0.9.12.tar.gz

Thanks for the report!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
