Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTI0NNi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 09:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTI0NNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 09:13:38 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:39942 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262439AbTI0NNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 09:13:37 -0400
Subject: Re: Ejecting a CardBus device
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030927112010.G3440@flint.arm.linux.org.uk>
References: <1064628015.1393.5.camel@teapot.felipe-alfaro.com>
	 <20030927082806.A681@flint.arm.linux.org.uk>
	 <1064657889.1381.1.camel@teapot.felipe-alfaro.com>
	 <20030927112010.G3440@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1064668405.3509.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Sep 2003 15:13:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-27 at 12:20, Russell King wrote:
> > 
> > I doesn't seem to work: "cardctl eject" complains that no pcmcia driver
> > appears in /proc/devices. Any ideas?
> 
> That'll be because ds got unloaded.  Although ds isn't required for
> cardbus cards, it does provide the interface to cardctl.

Bingo! Now APM suspend is working flawlessly for the very first time in
my life... Thanks.

