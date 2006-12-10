Return-Path: <linux-kernel-owner+w=401wt.eu-S1761856AbWLJWqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761856AbWLJWqL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 17:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761826AbWLJWqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 17:46:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43743 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761856AbWLJWqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 17:46:09 -0500
Date: Sun, 10 Dec 2006 14:39:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Daniel Drake <dsd@gentoo.org>, Adrian Bunk <bunk@stusta.de>,
       Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: PCI quirks update for 2.6.16
In-Reply-To: <20061210223351.GA22878@tuatara.stupidest.org>
Message-ID: <Pine.LNX.4.64.0612101438080.12500@woody.osdl.org>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org>
 <1165723779.334.3.camel@localhost.localdomain> <20061210160053.GD10351@stusta.de>
 <457C345D.8030305@gentoo.org> <20061210223351.GA22878@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Dec 2006, Chris Wedgwood wrote:
> 
> > If I remember right, it breaks Chris Wedgwood's box
> 
> I'm not bothered about 2.6.16.x anymore, feel free to do whatever is
> needed there.

That's really not the point.

What's the whole _reason_ for 2.6.x.y releases?

They should be safe, and OBVIOUS. 

If there is a box that breaks with a 2.6.x.y release, then that .y release 
was clearly a mistake, and fundamentally broke the whole point of the 
stable tree. If you can't depend on the stable tree being a real 
improvement - regardless of what hw you are on - then the stable tree has 
lost all meaning, and you'd be better off just getting 2.6.x+1 instead.

		Linus
