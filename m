Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVAHVHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVAHVHT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 16:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVAHVHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 16:07:19 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:4507 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261496AbVAHVHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 16:07:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
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
From: Andreas Schwab <schwab@suse.de>
X-Yow: Let's go to CHURCH!
Date: Sat, 08 Jan 2005 22:07:10 +0100
In-Reply-To: <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 8 Jan 2005 10:46:19 -0800 (PST)")
Message-ID: <je8y73zl35.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Another issue is likely that we should make the whole "uselib()"
> interfaces configurable. I don't think modern binaries use it (where
> "modern" probably means "compiled within the last 8 years" ;).

I don't think it was ever being used for anything besides a.out so IMHO it
should depend on BINFMT_AOUT.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
