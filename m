Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVGUCmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVGUCmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 22:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVGUCmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 22:42:10 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:61919 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261577AbVGUCmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 22:42:04 -0400
Message-ID: <62629.192.168.0.14.1121913705.squirrel@192.168.0.2>
In-Reply-To: <20050720175713.GA19403@atrey.karlin.mff.cuni.cz>
References: <20050711193454.GA2210@elf.ucw.cz>
    <33703.127.0.0.1.1121130438.squirrel@localhost>
    <20050719180624.GB15186@atrey.karlin.mff.cuni.cz>
    <20050719192104.GB32757@elf.ucw.cz>
    <1121804551.7499.55.camel@localhost.localdomain>
    <20050720175713.GA19403@atrey.karlin.mff.cuni.cz>
Date: Wed, 20 Jul 2005 21:41:45 -0500 (CDT)
Subject: Re: Sharp Zaurus sl-5500 broken in 2.6.12
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Richard Purdie" <rpurdie@rpsys.net>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, July 20, 2005 12:57 pm, Pavel Machek said:

> BTW is there some place where I can find modifications Sharp did to
> mainline 2.4 kernel?

First, sharp's modifications were not to the base 2.4 kernels, but you
first applied the rmk patch and then the pxa patch.

I have tried to split up the huge patch
http://www.cs.wisc.edu/~lenz/zaurus/files/slc860-patches.tar.bz2

But the original patch is hosted around here somewhere.  To find where,
take a look inside the .bb file inside OE... you should be able to check
out openembedded (from www.openembedded.org) and find the .bb file that
builds the kernel.

John

