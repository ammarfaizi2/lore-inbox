Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbULYNX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbULYNX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbULYNX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:23:26 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47255 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261412AbULYNXW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:23:22 -0500
Subject: Re: Ho ho ho - Linux v2.6.10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1103977161.22646.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 25 Dec 2004 12:19:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-24 at 22:39, Linus Torvalds wrote:
> Ok, with a lot of people taking an xmas break, here's something to play
> with over the holidays (not to mention an excuse for me to get into the
> Glögg for real ;)

Merry Yule to you too.

Not wishing to be too ungrateful to Santa but 

- The broken AX.25 patches are not reverted so that doesn't work on some
networks

- It seems the security hole inducing exec_id change was not reverted
and I've not yet found any other changes that fix the same problem
(setuid_app >/proc/self/mem) in 2.6.10. It was actually quite nasty as a
hole because you can seek the fd to the right target address before
execing. With the other /proc changes did I miss something on this one

I'll check it all over in more detail when I generate 2.6.10-ac
(probably tomorrow), which will be nice as the patch will be a _lot_
shorter and USB storage a lot happier than 2.6.9 based systems.

Alan

