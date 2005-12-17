Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVLQGn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVLQGn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 01:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVLQGn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 01:43:58 -0500
Received: from pat.uio.no ([129.240.130.16]:40359 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751152AbVLQGn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 01:43:58 -0500
Subject: Re: lockd: couldn't create RPC handle for (host)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20051217055907.GC20539@tau.solarneutrino.net>
References: <20051216205536.GA20497@tau.solarneutrino.net>
	 <1134776945.7952.4.camel@lade.trondhjem.org>
	 <20051216235841.GA20539@tau.solarneutrino.net>
	 <1134797577.20929.2.camel@lade.trondhjem.org>
	 <20051217055907.GC20539@tau.solarneutrino.net>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 01:43:42 -0500
Message-Id: <1134801822.7946.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.026, required 12,
	autolearn=disabled, AWL 1.79, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 00:59 -0500, Ryan Richter wrote:

> There's no filtering between the two.  I get this on the machine itself:
> $ rpcinfo -u localhost 100021
> rpcinfo: RPC: Timed out
> program 100021 version 0 is not available
> zsh: exit 1     rpcinfo -u localhost 100021
> 
> There's no lockd process running on this client machine anymore.

...yet the client still has the partition mounted, and isn't using the
-onolock option? That sounds weird.

Is the client also running 2.6.15-rc5?

Cheers,
  Trond

