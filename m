Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTJ0AAz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 19:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbTJ0AAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 19:00:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:5248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263679AbTJ0AAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 19:00:54 -0500
Date: Sun, 26 Oct 2003 16:01:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Linux 2.6.0-test9
Message-Id: <20031026160158.74bd09c8.akpm@osdl.org>
In-Reply-To: <UTC200310261940.h9QJeWa04880.aeb@smtp.cwi.nl>
References: <UTC200310261940.h9QJeWa04880.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
>     From: Linus Torvalds <torvalds@osdl.org>
> 
>     > I have run 2.6.0-test6 without any problems. Switched
>     > to 2.6.0-test9 today. Something involving job control
>     > or so is broken. Several of my remote xterms hang.
> 
>     Btw, this one sounds like a known bug in bash.
> 
> No - it is a recent kernel bug.
> Mikael Pettersson noticed precisely the same thing, and says
>  "Reverting 2.6.0-test8-bk3's net/ipv4/tcp.c patch fixes
>   these problems."
> And so it does.
> 

Can someone show us the diff for this?

