Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSLHKru>; Sun, 8 Dec 2002 05:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbSLHKru>; Sun, 8 Dec 2002 05:47:50 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:37126 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S265361AbSLHKrt>; Sun, 8 Dec 2002 05:47:49 -0500
Date: Sun, 8 Dec 2002 21:55:15 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch(2.5.50): Simplify crypto memory allocation
In-Reply-To: <20021208012727.A24577@baldur.yggdrasil.com>
Message-ID: <Mutt.LNX.4.44.0212082149400.23807-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Dec 2002, Adam J. Richter wrote:

> 	The following patch deletes the unused
> crypto_tfm.crt_work_block field and combines the remaining
> two kmallocs done by crypto_alloc_tfm into one, a net
> deletion of 25 lines.
> 
> 	I've only verified that the kernel and the crpypto modules
> still build.  I don't currently use this code, although I'm
> considering making a version of loop.c which would, which is why I
> noticed this.
> 
> 	Anyhow, if this patch turns out to work and looks OK, then
> please integrate, queue it for Linus, etc., or let me know if you
> would prefer that you or I follow some other course of action.
> 

Looks good and tests ok.  Thanks.  

(The work_block field and associated management code should have
disappeared long ago, not sure why it was still there).


- James
-- 
James Morris
<jmorris@intercode.com.au>


