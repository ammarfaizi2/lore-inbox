Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbTGHSZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbTGHSZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:25:33 -0400
Received: from ev2.cpe.orbis.net ([209.173.192.122]:35211 "EHLO srv.foo21.com")
	by vger.kernel.org with ESMTP id S267482AbTGHSZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:25:30 -0400
Date: Tue, 8 Jul 2003 13:40:05 -0500
From: Eric Varsanyi <e0206@foo21.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
Message-ID: <20030708184005.GS9328@srv.foo21.com>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com> <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com> <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com> <20030708154636.GM9328@srv.foo21.com> <Pine.LNX.4.55.0307080840400.4544@bigblue.dev.mcafeelabs.com> <20030708160206.GP9328@srv.foo21.com> <Pine.LNX.4.55.0307081005500.4792@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307081005500.4792@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did not have the time to test the patch in your scenario, but if you can
> confirm me it is working fine I'll push it.

Tested this morning, works fine for me. I haven't run any complex loads on
my new event loop, so I can't say it is exhaustively tested, but it passes
basic unit tests.

-Eric
