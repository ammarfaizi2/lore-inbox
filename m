Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbRFVREp>; Fri, 22 Jun 2001 13:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265472AbRFVREf>; Fri, 22 Jun 2001 13:04:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53241 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265469AbRFVREX>;
	Fri, 22 Jun 2001 13:04:23 -0400
Date: Fri, 22 Jun 2001 13:04:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac16 -- "proc_get_inode" still unresolved in /net/wan/comx.o
In-Reply-To: <Pine.LNX.4.30.0106192205270.24119-100000@aerie.megapathdsl.net>
Message-ID: <Pine.GSO.4.21.0106221301210.3434-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Jun 2001, Miles Lane wrote:

> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.5-ac16/kernel/drivers/net/wan/comx.o
> depmod: 	proc_get_inode

And it won't be exported. Moreover, it has a very good chance to become
static.

If you have the hardware in question and are willing to help with
testing I would be rather grateful. I'm rewriting filesystem side of
the driver (along with fixing rmmod races, etc.) and testers will be
needed somewhere in the middle of next week.

