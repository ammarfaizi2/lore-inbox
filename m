Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVLUPN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVLUPN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVLUPN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:13:29 -0500
Received: from main.gmane.org ([80.91.229.2]:40630 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932445AbVLUPN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:13:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: About 4k kernel stack size....
Date: Wed, 21 Dec 2005 10:07:01 -0500
Message-ID: <dobr1u$19t$1@sea.gmane.org>
References: <20051218231401.6ded8de2@werewolf.auna.net> <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de> <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com> <BAYC1-PASMTP01F075F44E45AA32F0DF85AE3E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18b8606d.dyn.optonline.net
User-Agent: KNode/0.9.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean wrote:

> I for one hope those silly bastards using ndiswrapper fix up that code to
                       ^^^^^^^^^^^^^^
It is despicable that some of the proponents of this 4k-only stack size have
resorted to such epithets. As I see, although people that rely on
ndiswrapper (since there is no other way they could use the hardware that
they have) will not be able to use their wireless cards when this patch
gets merged without having to patch the kernel, only a few comments have
been raised about it. There are other people that have raised concern not
related to ndiswrapper. Branding everyone that is raising a concern about
this patch into one group and calling them names is pathetic and
despondent.

While I am at it, let me _repeat_ that ndiswrapper itself is 4k-ready and a
few Windows drivers work with 4k stacks. And supporting private stacks, as
some people have suggested, may be possible in theory, but it is _very
hard_, considering that Windows uses different calling conventions
(fastcall, stdcall, cdecl) and a driver can use more than one thread. It is
futile on this thread to suggest to someone to come up with a patch to
implement private stacks in such an environment. And let me also repeat
that I have been working on implementing NDIS in user space, although there
are few issues with that too.

Giri



