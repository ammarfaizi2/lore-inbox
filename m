Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318231AbSIKARB>; Tue, 10 Sep 2002 20:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSIKARB>; Tue, 10 Sep 2002 20:17:01 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:50185 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318231AbSIKARA>; Tue, 10 Sep 2002 20:17:00 -0400
Date: Wed, 11 Sep 2002 02:20:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.5
In-Reply-To: <3D7E83F4.6050302@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0209110204180.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, 10 Sep 2002, Jeff Garzik wrote:

> How about posting a kernel patch (or link to one) that you feel is
> suitable for 2.5.x integration?  That makes it a bit easier to review in
> context, and may help to resolve any final integration issues.

That depends on what you want to see. The package itself is installed
under scripts/lkc ("make install" just makes a symlink) and is pretty much
the same you find in the archive (minus the converter). A problem here is
that the current kbuild can't deal with C++ files and builds too much
even if you just want a single target, so it's currently not using the
kbuild infrastructure.
The other big part are the converted config files, they are currently
generated as Config.new, so they can be easily removed again. A "final"
patch would be hardly readable. Installing (and uninstalling) the package
into a kernel tree is quite simple, so I prefer to do it this way to save
bandwidth.

> For the record I like what I've seen so far...

Thanks. :)

bye, Roman

