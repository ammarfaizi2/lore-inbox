Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVHQRrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVHQRrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 13:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVHQRrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 13:47:20 -0400
Received: from [64.162.99.240] ([64.162.99.240]:13735 "EHLO
	spamtest2.viacore.net") by vger.kernel.org with ESMTP
	id S1751162AbVHQRrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 13:47:20 -0400
Date: Wed, 17 Aug 2005 10:42:04 -0700 (PDT)
From: joebob@spamtest.viacore.net
X-X-Sender: joebob@spamtest2.viacore.net
To: Jon Jahren <shaoran.85@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Atheros and rt2x00 driver
In-Reply-To: <1124298943.22673.11.camel@gentoo.lan>
Message-ID: <Pine.LNX.4.63.0508171041430.14004@spamtest2.viacore.net>
References: <1124298943.22673.11.camel@gentoo.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005, Jon Jahren wrote:
> Hello, I'm new to the mailling list, and couldn't find any traces of
> discussing this anywhere. I was wondering why neither the atheros driver
> http://madwifi.sourceforge.net, or the rt2x00 driver
> http://rt2x00.serialmonkey.com/wiki/index.php/Main_Page is included in
> the kernel?

That's because a) these drivers are not "proven stable" -- ie they have
not released a well-tested, known-good, working version of the software
and b) they haven't asked for their software to be included in the kernel
(at least in the case of madwifi, anyways). c) madwifi also will probably
never be integrated into the mainstream kernel because it contains
binary-only proprietary software licensed by atheros communications (under
NDA by the developer). Since the kernel is released GPL, the source must
be made available for all parts of the kernel if desired. Code released
closed source cannot be included else we violate the terms of the GPL.
I'm not sure about rt2x00, but it may have a similar deficiency.

By the way, the best place to ask about why XX isn't included in the
kernel is with the developers of XX unless they tell you to ask here :)

Hope this clears some stuff up for you. ciao.

-kelsey

