Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbTKKAPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 19:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbTKKAPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 19:15:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:61581 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264165AbTKKAPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 19:15:31 -0500
Date: Mon, 10 Nov 2003 16:15:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Lieverdink <linux@cafuego.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ?
In-Reply-To: <6.0.0.22.2.20031111101721.01bde418@caffeine.cc.com.au>
Message-ID: <Pine.LNX.4.44.0311101613440.2881-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Nov 2003, Peter Lieverdink wrote:
> 
> I agree that something is very broken, though. Mind you, I can only 
> replicate this problem on one of my machines - the other one I've tried it 
> on seems to work fine. Odder still, when I compile a kernel on the machine 
> which is fine and ruin said kernel on the machine which is not fine, I 
> don't experience the crash.

That _really_ sounds like your "broken machine" is nothing more than a
broken compiler (or possibly binutils, but compilers tend to be more
fragile by far, so it's more likely the compiler).

What compiler versions do you have installed on the broken vs good
machines?

		Linus

