Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTJUUCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbTJUUCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:02:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:47494 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263303AbTJUUCU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:02:20 -0400
Date: Tue, 21 Oct 2003 16:05:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Chuck Campbell <campbell@accelinc.com>
cc: Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results are in
In-Reply-To: <20031021193128.GA18618@helium.inexs.com>
Message-ID: <Pine.LNX.4.53.0310211558500.19942@chaos>
References: <175701c397e6$b36e5310$24ee4ca5@DIAMONDLX60>
 <20031021193128.GA18618@helium.inexs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003, Chuck Campbell wrote:

> On Wed, Oct 22, 2003 at 12:18:33AM +0900, Norman Diamond wrote:
> > It still seems that either Linux must
> > be made to work around known bad blocks or else hard disks and Linux cannot
> > be used together on a computer.
>
> That is a bit of a troll.  I suspect that 70 - 90 percent of linux
> installations on a computer are using hard disks.  Yet the number of people
> having the same problem as you doesn't appear to be 100% of those.
>
> Making intentionally inflammatory statements to try and win others to your
> point of view tends to do exactly the opposite.
>
> If there are enough people experiencing the problem, it gets fixed, at least
> as far as I can tell.  There have been a nunmber of viable ideas proposed
> in this thread to handle the situation you are talking about, and while
> none of them are exactly what you proposed, feel free to write code.  Baiting
> comments like the above don't really accomplish anything constructive.
>
> -chuck

I thought both ext2 and ext3 do handle bad-blocks. They just
don't make them owned by a "file" because the Unix file-systems
don't require dummy directory entries.

If the respondent wants them isolated into a "BADBLOCKS" file,
he can make a utility to do that. It's really quite easy because
you can raw-read disks under Linux, plus there is already
the `badblocks` program that will locate them.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


