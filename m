Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUJONyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUJONyK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUJONvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:51:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:24704 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267776AbUJONup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:50:45 -0400
Date: Fri, 15 Oct 2004 09:50:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: __attribute__((unused))
In-Reply-To: <1097843465.9862.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0410150948400.24590@chaos.analogic.com>
References: <20041014220243.B28649@flint.arm.linux.org.uk> 
 <1097791496.5788.2034.camel@baythorne.infradead.org> 
 <20041014230802.C28649@flint.arm.linux.org.uk> <1097843465.9862.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Alan Cox wrote:

> On Iau, 2004-10-14 at 23:08, Russell King wrote:
>> It's the "later compilers" which I'm worried about here - I think they
>> defined "unused" to mean "this really really isn't used and you can
>> discard it".  Hence my concern with the above.
>
> This was the explanation I got some time ago
>
> -- quote --
>
> So "used" cases that used "unused" could break, though older compilers
> in essence used "unused" to mean both "used" and "unused".  Since
> "unused" becomes useless for using in "used" cases, we now must be sure
> to use "used" when that's the use that's useful.
> 			-- Roland McGrath
>
>
> I found it so helpful it became a .sig 8)
>
Yes. Just like "less" is more than "more"......and whos on first base.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

