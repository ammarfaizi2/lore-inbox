Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbUBURjk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 12:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbUBURjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 12:39:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:35553 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261587AbUBURjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 12:39:39 -0500
Date: Sat, 21 Feb 2004 09:44:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Stephen Hemminger <shemminger@osdl.org>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
In-Reply-To: <20040221173449.GA277@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0402210944050.3301@ppc970.osdl.org>
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net>
 <Pine.LNX.4.58.0402181502260.18038@home.osdl.org> <20040221141608.GB310@elf.ucw.cz>
 <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org> <20040221173449.GA277@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Feb 2004, Pavel Machek wrote:
>
> I'm just afraid that someone will mail you a patch replacing that with
> >> 32 and you'll overlook it.

Well, the good news is that ">> 32" should cause gcc to complain with a 
big warning (exactly because it's undefined brhaviour on a 32-bit 
architecture), so I don't think it's easy to overlook.

		Linus
