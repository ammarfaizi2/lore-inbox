Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVADSDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVADSDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVADSDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:03:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:4260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261743AbVADSD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:03:28 -0500
Date: Tue, 4 Jan 2005 10:03:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: dtor_core@ameritech.net
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [bk patches] Long delayed input update
In-Reply-To: <d120d50005010408232e29661@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0501041002060.2294@ppc970.osdl.org>
References: <20041227142821.GA5309@ucw.cz>  <200412271419.46143.dtor_core@ameritech.net>
  <20050103131848.GH26949@ucw.cz>  <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
  <20050104135859.GA9167@ucw.cz>  <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org>
  <20050104160830.GA13125@ucw.cz>  <Pine.LNX.4.58.0501040812420.2294@ppc970.osdl.org>
 <d120d50005010408232e29661@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Jan 2005, Dmitry Torokhov wrote:
> 
> i8042-style ports are not limited to PC - maceps2.c, q40kbd.c,
> rpckbd.c and sa1111ps2.c also implement them that's why libps2 wasn't
> limited to x86 arch.

So?

If you select ATKBD then LIBPS2 should be selected _automatically_.

My point is that there is _never_ a reason to ask about it. Ever.

I'll let crazy people select EMBEDDED if they want to see the question, 
but even that is in my opinion likely unnecessary.

		Linus
