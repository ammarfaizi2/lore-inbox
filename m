Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261694AbSI0Mmw>; Fri, 27 Sep 2002 08:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSI0Mmw>; Fri, 27 Sep 2002 08:42:52 -0400
Received: from ns.suse.de ([213.95.15.193]:36359 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261694AbSI0Mmv>;
	Fri, 27 Sep 2002 08:42:51 -0400
To: jbradford@dial.pipex.com
Cc: arjanv@redhat.com (Arjan van de Ven), Daniel.Heater@gefanuc.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       jgarzik@pobox.com
Subject: Re: Distributing drivers independent of the kernel source tree
References: <200209271240.g8RCeiBH000229@darkstar.example.net>
X-Yow: I know how to get the hostesses released!  Give them their own
 television series!
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 27 Sep 2002 14:48:09 +0200
In-Reply-To: <200209271240.g8RCeiBH000229@darkstar.example.net> (jbradford@dial.pipex.com's
 message of "Fri, 27 Sep 2002 13:40:43 +0100 (BST)")
Message-ID: <jed6qzy4xi.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbradford@dial.pipex.com writes:

|> > > 2. Assuming the kernel source is in /usr/src/linux is not always valid.
|> > >=20
|> > > 3. I currently use /usr/src/linux-`uname -r` to locate the kernel source
|> > > which is just as broken as method #2.
|> > 
|> > you have to use
|> > 
|> > /lib/modules/`uname -r`/build
|> > (yes it's a symlink usually, but that doesn't matter)
|> > 
|> > 
|> > that's what Linus decreed and that's what all distributions honor, and
|> > that's that make install does for manual builds.
|> 
|> What about instances where there is no modular support in the kernel?

If your kernel has no module support then you cannot compile kernel
modules.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
