Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267053AbRHFHLE>; Mon, 6 Aug 2001 03:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267055AbRHFHKx>; Mon, 6 Aug 2001 03:10:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53487 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267053AbRHFHKi>;
	Mon, 6 Aug 2001 03:10:38 -0400
Date: Mon, 6 Aug 2001 03:10:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Gergely Madarasz <gorgo@sztaki.hu>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-pre4 drivers/net/wan/comx.c unresolved symbol
In-Reply-To: <Pine.GS4.4.33.0108060857040.5076-100000@lutra.sztaki.hu>
Message-ID: <Pine.GSO.4.21.0108060309440.13716-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2001, Gergely Madarasz wrote:

> On Mon, 6 Aug 2001, Keith Owens wrote:
> 
> > This is probably already known but 2.4.8-pre4 drivers/net/wan/comx.c
> > has an unresolved symbol proc_get_inode when compiled as a module.
> >
> > I was pleasently suprised when doing a full kernel compile as modules.
> > 840 modules created, only one unresolved symbol.
> 
> It is using a symbol which was exported in 2.2, but is not exported in
> 2.4. Either the driver needs a major rewrite to work as a module (it works
> compiled into the kernel) or proc_get_inode needs to be exported again.

The driver needs a major rewrite to work.

