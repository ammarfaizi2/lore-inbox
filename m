Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVAHXWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVAHXWB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 18:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVAHXWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 18:22:01 -0500
Received: from one.firstfloor.org ([213.235.205.2]:61885 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262010AbVAHXV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 18:21:58 -0500
To: Andreas Schwab <schwab@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
	<20050107170712.GK29176@logos.cnet>
	<1105136446.7628.11.camel@localhost.localdomain>
	<Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org>
	<20050107221255.GA8749@logos.cnet>
	<Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>
	<je8y73zl35.fsf@sykes.suse.de>
From: Andi Kleen <ak@muc.de>
Date: Sun, 09 Jan 2005 00:21:56 +0100
In-Reply-To: <je8y73zl35.fsf@sykes.suse.de> (Andreas Schwab's message of
 "Sat, 08 Jan 2005 22:07:10 +0100")
Message-ID: <m1zmzjv757.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> Another issue is likely that we should make the whole "uselib()"
>> interfaces configurable. I don't think modern binaries use it (where
>> "modern" probably means "compiled within the last 8 years" ;).
>
> I don't think it was ever being used for anything besides a.out so IMHO it
> should depend on BINFMT_AOUT.

I will disable it from 64bit x86-64. I would recommend that all other
ELF only architectures do the same.

-Andi
