Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVJMWob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVJMWob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 18:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVJMWob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 18:44:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63147 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964810AbVJMWob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 18:44:31 -0400
Date: Fri, 14 Oct 2005 00:44:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, zaurus@orca.cx,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: spitz (zaurus sl-c3000) support
Message-ID: <20051013224419.GF1876@elf.ucw.cz>
References: <20051012223036.GA3610@elf.ucw.cz> <1129158864.8340.20.camel@localhost.localdomain> <20051012233917.GA2890@elf.ucw.cz> <1129192418.8238.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129192418.8238.21.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I got spitz machine today. I thought oz3.5.3 for spitz would be
> > > > 2.6-based, but found out that I'm not _that_ fortunate.
> > > 
> > > oz 3.5.4 is due for release soon and will hopefully have a 2.6 option
> > > for spitz.
> > 
> > Is there chance to get preview version somewhere? 2.6-capable userland
> > would be very nice (and zImage would help, too, just for a demo :-).
> 
> I'm no sure offical preview images exist but here's something I built
> myself recently:
> 
> http://www.rpsys.net/openzaurus/temp/spitz/

Thanks. Kernel works, even with 3.5.3 opie. [But touchscreen gets
extremely interesting, you have to click top-right corner to get it to
register click in bottom-left].

> Rename the gpe or opie file "hdimage1.tgz" to flash depending on what
> flavoured image you'd like. You need the other files including gnu-tar.
> You don't need an initrd.bin file as under 2.6 we can boot directly from
> the microdrive.

You mean I should place tar binary on flashcard, because updater.sh
needs it? [What is updater.sh anyway, xor 0x5e encrypted shell
script?!]

> > Wildly offtopic... I got poweradapter with spitz (with funny design)
> > that says 100V (and lot of japanese letters).. I guess it would be
> > very bad idea to try it at 240V?
> 
> Trust me, its a very bad idea...

Oh, okay, one more question. Do you trust your battery charging code
enough to leave spitz overnight in charger? I would hate to be awaken
by angry lithium ;-).

								Pavel
-- 
Thanks, Sharp!
