Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUI0Lhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUI0Lhm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 07:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUI0Lhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 07:37:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33762 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266703AbUI0Lhb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 07:37:31 -0400
Date: Mon, 27 Sep 2004 12:37:27 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make make install install modules too
Message-ID: <20040927113727.GQ16153@parcelfarce.linux.theplanet.co.uk>
References: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk> <20040927072246.GA8613@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927072246.GA8613@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 09:22:46AM +0200, Sam Ravnborg wrote:
> On Fri, Sep 17, 2004 at 06:00:51PM +0100, Matthew Wilcox wrote:
> > 
> > I keep forgetting to run 'make modules_install' after make install.  Since
> > make now compiles modules too and there's no separate make modules step,
> > it seems to make sense that make install should also install modules.
> 
> No, we do not want to change such basic behaviour.
> So many poeple are used to current scheme with:
> make modules_install && make install
> 
> that it would't be worth breaking their ways of working.

Ehm, this wouldn't _break_ them.  They'd just end up installing modules
twice.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
