Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267381AbSLLA3r>; Wed, 11 Dec 2002 19:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbSLLA3r>; Wed, 11 Dec 2002 19:29:47 -0500
Received: from dp.samba.org ([66.70.73.150]:62154 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267377AbSLLA3p>;
	Wed, 11 Dec 2002 19:29:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, dahinds@users.sourceforge.net,
       davem@vger.kernel.org
Subject: Re: Status new-modules + 802.11b/IrDA 
In-reply-to: Your message of "Wed, 11 Dec 2002 12:40:36 CDT."
             <20021211174036.GA2612@gtf.org> 
Date: Thu, 12 Dec 2002 09:41:49 +1100
Message-Id: <20021212003733.57AA62C25A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021211174036.GA2612@gtf.org> you write:
> On Wed, Dec 11, 2002 at 07:34:53PM +1100, Rusty Russell wrote:
> > idra-usb.c: add "netdev->owner = THIS_MODULE;" and get rid of the
> > 	MOD_INC_USE_COUNT.
> 
> 	Incorrect but close:  one uses SET_MODULE_OWNER(netdev) for this.

BTW, what *is* the purpose of that macro, other than obfuscation?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
