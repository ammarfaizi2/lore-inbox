Return-Path: <linux-kernel-owner+w=401wt.eu-S1762882AbWLKMv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762882AbWLKMv5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 07:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762886AbWLKMv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 07:51:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2709 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1762882AbWLKMv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 07:51:57 -0500
Date: Mon, 11 Dec 2006 13:52:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, Daniel Drake <dsd@gentoo.org>,
       Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@redhat.com>
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-ID: <20061211125206.GK10351@stusta.de>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org> <1165723779.334.3.camel@localhost.localdomain> <20061210160053.GD10351@stusta.de> <457C345D.8030305@gentoo.org> <20061210223351.GA22878@tuatara.stupidest.org> <Pine.LNX.4.64.0612101438080.12500@woody.osdl.org> <20061210234733.GH10351@stusta.de> <Pine.LNX.4.64.0612101721070.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612101721070.12500@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 05:23:59PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Dec 2006, Adrian Bunk wrote:
> > 
> > If life was that easy...  ;-)
> 
> No. Life _is_ that easy.
> 
> If the 2.6.16 stable tree took a patch that was questionable, and we don't 
> know what the right answer to it is from the _regular_ tree, than the 
> patch violated the stable tree rules in the first place and should just be 
> reverted.
> 
> Once people know what the right answer is (and by "know", I mean: "not 
> guess") from the regular tree having been tested with it, and people 
> understanding the problem, then it can be re-instated.
> 
> But if you're just guessing, and people don't _know_ the right answer, 
> then just revert the whole questionable area.  The patch shouldn't have 
> been there in the first place.
> 
> It really _is_ that simple.
> 
> Either it's a stable tree or it isn't. 


The non-easy part is that the patch that turned out as being 
questionable was merged back in May, and that it actually fixed issues 
for some people...

Unless you can lend me a time machine for telling Greg and Chris Wr. 
that they mustn't merge this patch for 2.6.16.17, there doesn't seem to 
be any regression free solution available at the moment.


> 		Linus


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

