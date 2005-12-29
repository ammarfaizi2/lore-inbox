Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVL2Ve7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVL2Ve7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 16:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVL2Ve7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 16:34:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:22243 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751022AbVL2Ve6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 16:34:58 -0500
Date: Thu, 29 Dec 2005 22:34:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 12/13] mutex subsystem, VFS [experimental]: convert ->i_sem to ->i_mutex
Message-ID: <20051229213434.GA6106@elte.hu>
References: <20051229210521.GM665@elte.hu> <Pine.LNX.4.64.0512291326230.3298@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512291326230.3298@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Ingo, 
>  you missed attribution on this. Please don't. A 
> 
> 	From: Jes Sorensen <jes@sgi.com> 

hm, i thought Jes having the first S-o-b line makes it well-defined that 
he is the author? I did that similarly for the other patches too: the 
primary author has the first S-o-b line, and that's definitely not 
always me in this series: Nico and Arjan have written portions too. (i 
have added my S-o-b lines because i obviously refactored the patches and 
did some changes to them too most of the time, but only as secondary 
lines)

I only add "From:" if i dont have a S-o-b line from someone. Am i 
applying the S-o-b protocol incorrectly?

	Ingo
