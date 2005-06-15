Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVFOWh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVFOWh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVFOWh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:37:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23531 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261269AbVFOWhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:37:54 -0400
Date: Wed, 15 Jun 2005 15:39:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bongani Hlope <bonganilinux@mweb.co.za>
cc: Andrew Morton <akpm@osdl.org>, ak@muc.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Tracking a bug in x86-64
In-Reply-To: <200506160020.21688.bonganilinux@mweb.co.za>
Message-ID: <Pine.LNX.4.58.0506151536000.8487@ppc970.osdl.org>
References: <200506132259.22151.bonganilinux@mweb.co.za>
 <Pine.LNX.4.58.0506140819440.8487@ppc970.osdl.org> <20050614132721.3b55c196.akpm@osdl.org>
 <200506160020.21688.bonganilinux@mweb.co.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Jun 2005, Bongani Hlope wrote:
>
> push 410, pop 205, pop 103, push 103, pop 51, pop 26, push 13, pop 6, push 4 and push 1
> This points to: randomisation-top-of-stack-randomization.patch

Goodie.

Can you verify (just to make doubly sure that there are no subtle
interactions anywhere) that the current top-of-tree with that _one_ patch
reverted ends up working for you?

Anyway, thanks a heap for spending the time narrowing this down!

		Linus
