Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263275AbREaW7s>; Thu, 31 May 2001 18:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263274AbREaW7j>; Thu, 31 May 2001 18:59:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58386 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263272AbREaW7Z>; Thu, 31 May 2001 18:59:25 -0400
Subject: Re: 2.4.5 VM
To: vichu@digitalme.com (Trever L. Adams)
Date: Thu, 31 May 2001 23:57:23 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3B16CC23.1020202@digitalme.com> from "Trever L. Adams" at May 31, 2001 06:56:35 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155bNb-0008BK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually I have tried 1x,2x,3x.  In 2.4.0 to 2.4.3 I had some issues but 
> never a system freeze of any kind.  With 2.4.4 I had more problems, but 
> I was ok.  2.4.5 I now have these freezes.  Maybe I should go back to 
> 2x, but I still find this behavior crazy.
> This still doesn't negate the point of freeing simple caches.

The caches are in part shared. Remember page cache memory and read only
application pages are the same thing - so its not that simple. I found 2.4.5
pretty bad. 2.4.5-ac seems to be better on the whole but I know its definitely
not right yet. Marcelo and Rik are working on that more and more.

Marcelo has a test patch to fix the (documented but annoying) 2x memory
swap rule stuff. The balancing problem is harder but being worked on.

If you can give Rik a summary of your config/what apps run/ps data then it
may be valuable as he can duplicate your exact setup for testing his
vm changes and add it to the test sets.

Alan

