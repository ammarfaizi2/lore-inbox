Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTKJEJv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 23:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTKJEJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 23:09:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:45503 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262848AbTKJEJu (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 23:09:50 -0500
Date: Sun, 9 Nov 2003 20:09:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Andrew Morton <akpm@osdl.org>, Burton Windle <bwindle@fint.org>,
       <Linux-kernel@vger.kernel.org>
Subject: Re: slab corruption in test9 (NFS related?)
In-Reply-To: <16303.131.838605.661991@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.44.0311092007451.3002-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Nov 2003, Neil Brown wrote:
>
> An extra dput was introduced in nfsd_rename 20 months ago....
> 
> time to remove it.

Oh, you stand-up comedian you.

I'm just wondering how the hell this hasn't bit us seriously until now?  
What's up?

In other words, your patch certainly looks obviously correct, but it also
looks _so_ obviously correct that my alarm bells are going off. If the
code was quite that broken at counting dentries, how the hell did it ever
work AT ALL?

Call me suspicious, but I find this really strange..

		Linus

