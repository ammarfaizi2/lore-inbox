Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWBDQIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWBDQIM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWBDQIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:08:12 -0500
Received: from khc.piap.pl ([195.187.100.11]:22281 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932303AbWBDQIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:08:11 -0500
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org>
	<1138844838.5557.17.camel@localhost.localdomain>
	<43E2B8D6.1070707@aarnet.edu.au>
	<20060203094042.GB30738@flint.arm.linux.org.uk>
	<43E36850.5030900@aarnet.edu.au>
	<20060203160218.GA27452@flint.arm.linux.org.uk>
	<m3lkwse3nz.fsf@defiant.localdomain>
	<20060203221346.GA10700@flint.arm.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 04 Feb 2006 17:08:10 +0100
In-Reply-To: <20060203221346.GA10700@flint.arm.linux.org.uk> (Russell King's message of "Fri, 3 Feb 2006 22:13:46 +0000")
Message-ID: <m3mzh7ds45.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> Stop throwing FUD into this issue.  The original claim was that a
> non-root user could send arbitary strings via the console system.
> This was an independent claim from the other issues.

That is clearly another thing and would probably need to be
demonstrated. Anyway, the AT* problem[1] doesn't require a user
action and the fix proposed (if correct) would fix the real AT*
problem instead.

[1] I don't call it a bug, it's rather a lack of functionality,
we just don't seem to support dial-in Hayes modems with serial
console.

I don't see any FUD here.
-- 
Krzysztof Halasa
