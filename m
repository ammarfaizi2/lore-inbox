Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbTA2E4l>; Tue, 28 Jan 2003 23:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTA2E4D>; Tue, 28 Jan 2003 23:56:03 -0500
Received: from dp.samba.org ([66.70.73.150]:40143 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264620AbTA2E4B>;
	Tue, 28 Jan 2003 23:56:01 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: GertJan Spoelman <kl@gjs.cc>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Trivial: Changes all <module>.o to .ko in Kconfig files 
In-reply-to: Your message of "Fri, 24 Jan 2003 00:03:29 BST."
             <200301240003.29824.kl@gjs.cc> 
Date: Wed, 29 Jan 2003 15:54:38 +1100
Message-Id: <20030129050522.471442C653@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200301240003.29824.kl@gjs.cc> you write:
> 
> --------------Boundary-00=_T1W6C6TJ1EXFI4RML77P
> Content-Type: text/plain;
>   charset="us-ascii"
> Content-Transfer-Encoding: 8bit
> 
> This patch goes against 2.5.59 and changes every <modulename>.o to 
> <modulename>.ko in every Kconfig they occur, except the ones I overlooked ;)
> It's a rather large patch so it's gzipped and attached.

I'd prefer just trimming the extension.  "modprobe foo" is what they
want to know.

It also sets the prefix of the parameters, when/if they are updated.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
