Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUCKPW2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUCKPWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:22:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35720 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261412AbUCKPUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:20:54 -0500
Date: Thu, 11 Mar 2004 10:22:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Valdis.Kletnieks@vt.edu
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0) 
In-Reply-To: <200403111503.i2BF3uDY010930@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.53.0403111020230.28486@chaos>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
 <20040310100215.1b707504.rddunlap@osdl.org>           
 <Pine.LNX.4.53.0403101324120.18709@chaos> <200403111503.i2BF3uDY010930@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004 Valdis.Kletnieks@vt.edu wrote:

> On Wed, 10 Mar 2004 13:33:53 EST, "Richard B. Johnson" said:
>
> > People who develop kernel code know the difference between
> > '==' and '=' and are never confused my them. If you make
>
> Remember a few months ago when a lot of very clever people looked at
> a line of code that said 'if (yadda yadda && (uid = 0))' that had been
> inserted into the CVS tree, and it took a while for some of the very clever
> people to notice the equally clever hack?
>

No, and if you bothered to look at any code in the kernel, you'd
note that uid and friends are always associated with some little
pointy thingys. So, it wouldn't have been coded anything like that,
anyway.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


