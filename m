Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUEVOdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUEVOdT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUEVOdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:33:19 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:40869 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261396AbUEVOdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:33:18 -0400
Date: Sat, 22 May 2004 16:32:14 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioctl number 0xF3
Message-ID: <20040522163214.A32228@electric-eye.fr.zoreil.com>
References: <40AF42B3.8060107@winischhofer.net> <1085228451.14486.0.camel@laptop.fenrus.com> <40AF4A13.4020005@winischhofer.net> <20040522125108.GB4589@devserv.devel.redhat.com> <40AF55AF.2020506@winischhofer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40AF55AF.2020506@winischhofer.net>; from thomas@winischhofer.net on Sat, May 22, 2004 at 03:29:19PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Winischhofer <thomas@winischhofer.net> :
[...]
> Don't get me wrong.. did you ever write a driver for graphics hardware? 

He can surely tell when an egg stinks. However Arjan is not a chicken.

[...]
> Is 64 out of, what's that, 65536 too much to ask? Well, I could live 
> with 32 as well...

Reserving a generous ioctl range without any clear interface will make
some people nervous. If you can not specify the interface now, try to
separate the generic/specific part of it and use sub-ioctl for the really
scary things as it will make the future life easier.

If you have some pointers to the existing code, that may help too.

--
Ueimor
