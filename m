Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSK0Euc>; Tue, 26 Nov 2002 23:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSK0Euc>; Tue, 26 Nov 2002 23:50:32 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1028 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id <S261568AbSK0Eub>;
	Tue, 26 Nov 2002 23:50:31 -0500
Date: Tue, 26 Nov 2002 22:49:32 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module_param() 1/3
In-Reply-To: <20021126065343.B48DE2C04E@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211262246230.833-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Rusty Russell wrote:

> Linus,
> 	This is the core support, with the out-by-one error which made
> it not boot with 0 params fixed (Doh!).  Tested on 2.5.49 (with a test
> parameter and without).

System is RedHat 8.0 with mod-init tools 0.7 added.  I pulled down a fresh 
2.5.49 tarball and added all three of your patches.  

modprobe pcmcia_core gives the following error:

pcmcia_core: falsely claims to have parameter t
FATAL: Error inserting /lib/modules/2.5.49/kernel/pcmcia_core.o: Invalid argument


