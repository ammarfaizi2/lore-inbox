Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbTLINzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265846AbTLINzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:55:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15493 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265845AbTLINzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 08:55:17 -0500
Date: Tue, 9 Dec 2003 08:56:43 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephen Satchell <list@satchell.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Swap performance statistics in 2.6 -- which /proc file has it?
In-Reply-To: <1070975964.5966.5.camel@ssatchell1.pyramid.net>
Message-ID: <Pine.LNX.4.53.0312090854080.8425@chaos>
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
  <1070911748.2408.39.camel@dhcppc4>  <3FD546D5.2000003@nishanet.com>
 <1070975964.5966.5.camel@ssatchell1.pyramid.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Stephen Satchell wrote:

> OK, color me stupid.  I just grepped the entire Documentation directory
> for 2.6.0-test11, and couldn't find anywhere where the number of disk
> requests for swap, or the swap transfer volume, is provided.  In 2.4 I
> had a single place where all swap activity (whether it was to a separate
> partition or to a file on a mounted file system) is recorded.
>
> I also grepped the proc filesystem source (linux/fs/proc) for "swap" and
> "Swap" and didn't find anything that had to do with swap request accounting,
> only with swap memory allocation (which I do use, but which for me is only
> half the story).
>

/proc/meminfo may give you the information you need, just not
as directly as you propose.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


