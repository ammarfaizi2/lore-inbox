Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbTCKEAx>; Mon, 10 Mar 2003 23:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262805AbTCKEAx>; Mon, 10 Mar 2003 23:00:53 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:59660 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262804AbTCKEAw>; Mon, 10 Mar 2003 23:00:52 -0500
Date: Tue, 11 Mar 2003 04:11:32 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt_ioctl() stack size reduction (v2)
In-Reply-To: <3E6D4E8C.46002A13@verizon.net>
Message-ID: <Pine.LNX.4.44.0303110410560.17590-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
> 
> This patch (to 2.5.64) reduces stack size usage in
>   drivers/char/vt_ioctl.c::vt_ioctl()
> from 0x334 bytes to 0xec bytes (P4, UP, gcc 2.96).
> 
> James, are you the maintainer of this module?

Yes. Sorry I have been busy fbdev hacking. Looks good. I will test and 
apply to my BK tree.
 
> Comments, anyone?
> 
> Thanks to Ingo Oeser for one suggestion -- applied.

