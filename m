Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSJUObT>; Mon, 21 Oct 2002 10:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSJUObT>; Mon, 21 Oct 2002 10:31:19 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:6576 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261448AbSJUObS>; Mon, 21 Oct 2002 10:31:18 -0400
Date: Mon, 21 Oct 2002 09:37:20 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: bert hubert <ahu@ds9a.nl>
cc: Neil Brown <neilb@cse.unsw.edu.au>, <linux-kernel@vger.kernel.org>
Subject: Re: nfsd/sunrpc boot on reboot in 2.5.44
In-Reply-To: <20021021063454.GA5898@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0210210933340.28262-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, bert hubert wrote:

> I also found this to work:
> 
> touch sunrpc.c
> make
> [ observe how sunrpc.o gets compiled ]
> [ add a -g to the commandline ]
> gdb sunrpc.o
> l *(auth_domain_drop+0x50)

Or even

	make fs/sunrpc/svc_auth.lst

and stare at fs/sunrpc/svc_auth.lst ;)

(it also gives you a svc_auth.o compiled with -g, so you can use the gdb 
thing above, too)

--Kai


