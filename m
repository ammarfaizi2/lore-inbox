Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUCXP2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbUCXP2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:28:24 -0500
Received: from mail.shareable.org ([81.29.64.88]:56976 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263742AbUCXP2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:28:21 -0500
Date: Wed, 24 Mar 2004 15:28:00 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Hans-Peter Jansen <hpj@urpla.net>, Robert_Hentosh@Dell.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: spurious 8259A interrupt
Message-ID: <20040324152800.GA5758@mail.shareable.org>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com> <20040319130609.GE2650@mail.shareable.org> <Pine.LNX.4.53.0403190825070.929@chaos> <200403211858.07445.hpj@urpla.net> <Pine.LNX.4.53.0403220713160.13879@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0403220713160.13879@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> It isn't CPU-specific. It's motherboard glitch specific. If there
> is ground-bounce on the motherboard or excessive induced
> coupling, the CPU may occasionally get hit with a logic-level
> that it "thinks" is an interrupt, even though no controller
> actually generated it.

That doesn't seem plausible on an otherwise reliable computer.

Why would interrupt lines suffer ground-bounce logic glitches yet all
the data, address and control lines be fine?

-- Jamie
