Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTJ0TRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTJ0TRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:17:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:8378 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263515AbTJ0TRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:17:38 -0500
Date: Mon, 27 Oct 2003 11:18:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transmit timeout with 3c395, 2.4.19, 2.4.22
Message-Id: <20031027111827.07b04891.akpm@osdl.org>
In-Reply-To: <20031027141358.GA26271@gamma.logic.tuwien.ac.at>
References: <20031027141358.GA26271@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> Hi Andrew, hi list!
> 
> Suddenly, after 160 days of running, our bridged firewall started to
> spit out this:
> NETDEV WATCHDOG: eth1: transmit timed out
>
> ...
>
> This always happened with eth1, so we think it *may* a hardware error
> creeping in. I would like to know wether this can be the case, or
> wether there is something else (switches on the other side, ...) which
> may have produced these errors.

Yes, a bad cable might explain this.  Or another host which is babbling
away all the time (on a half-duplex setup).

