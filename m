Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWD0CTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWD0CTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWD0CTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:19:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964884AbWD0CTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:19:05 -0400
Date: Wed, 26 Apr 2006 19:18:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
In-Reply-To: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Apr 2006, David Woodhouse wrote:
>
> Andrew (or preferably Linus since these are fairly simple and
> unintrusive bug fixes), please pull from my tree at 
> git://git.infradead.org/hdrcleanup-2.6.git

Hmm. Every time we've done this in the past, something has broken, so I'd 
actually _much_ rather wait until early in the 2.6.18 cycle than do it 
now.

Yeah, people shouldn't include kernel headers, but if they didn't, this 
patch wouldn't matter. And when they do, patches like this tends to show 
some strange app that depends on the current header layout.. Gaah.

		Linus
