Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269256AbUJWDFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269256AbUJWDFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269309AbUJWDEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:04:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:44781 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269109AbUJWDEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 23:04:09 -0400
Date: Fri, 22 Oct 2004 20:04:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue... - net/ipv4/netfilter/ipt_hashlimit.c
 does not build
In-Reply-To: <4179C405.1010805@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.58.0410222003480.2101@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
 <4179C405.1010805@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Oct 2004, Eyal Lebedinsky wrote:
>
>    CC [M]  net/ipv4/netfilter/ipt_hashlimit.o
> net/ipv4/netfilter/ipt_hashlimit.c: In function `__dsthash_find':
> net/ipv4/netfilter/ipt_hashlimit.c:124: error: structure has no member named `locked_by'

Yes. Disable NETFILTER_DEBUG for now.

		Linus
