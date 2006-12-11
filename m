Return-Path: <linux-kernel-owner+w=401wt.eu-S1758983AbWLKB2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758983AbWLKB2V (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 20:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758878AbWLKB2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 20:28:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57718 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758983AbWLKB2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 20:28:20 -0500
Date: Sun, 10 Dec 2006 17:23:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Chris Wedgwood <cw@f00f.org>, Daniel Drake <dsd@gentoo.org>,
       Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@redhat.com>
Subject: Re: RFC: PCI quirks update for 2.6.16
In-Reply-To: <20061210234733.GH10351@stusta.de>
Message-ID: <Pine.LNX.4.64.0612101721070.12500@woody.osdl.org>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org>
 <1165723779.334.3.camel@localhost.localdomain> <20061210160053.GD10351@stusta.de>
 <457C345D.8030305@gentoo.org> <20061210223351.GA22878@tuatara.stupidest.org>
 <Pine.LNX.4.64.0612101438080.12500@woody.osdl.org> <20061210234733.GH10351@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Adrian Bunk wrote:
> 
> If life was that easy...  ;-)

No. Life _is_ that easy.

If the 2.6.16 stable tree took a patch that was questionable, and we don't 
know what the right answer to it is from the _regular_ tree, than the 
patch violated the stable tree rules in the first place and should just be 
reverted.

Once people know what the right answer is (and by "know", I mean: "not 
guess") from the regular tree having been tested with it, and people 
understanding the problem, then it can be re-instated.

But if you're just guessing, and people don't _know_ the right answer, 
then just revert the whole questionable area.  The patch shouldn't have 
been there in the first place.

It really _is_ that simple.

Either it's a stable tree or it isn't. 

		Linus
