Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272428AbTG3B0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272547AbTG3B0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:26:37 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42883 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272428AbTG3B0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:26:36 -0400
Date: Wed, 30 Jul 2003 02:25:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       James Simmons <jsimmons@infradead.org>, Charles Lepple <clepple@ghz.cc>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030730012533.GA18663@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <Pine.LNX.4.53.0307291338260.6166@chaos> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> > If the machine had blanking disabled by default, then the
> > usual SYS-V startup scripts could execute setterm to enable
> > it IFF it was wanted.
> 
> optimise for the common case, just fix your box and be done with it.

One of Richard's points is that there is presently no way to fix the
box in userspace.  If the kernel crashes during boot, it will blank
the screen and there is no way to unblank it in that state.

-- Jamie
