Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTJFTaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbTJFTaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:30:24 -0400
Received: from linuxhacker.ru ([217.76.32.60]:42972 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261311AbTJFTaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:30:20 -0400
Date: Mon, 6 Oct 2003 22:29:00 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: "Max A. Krasilnikov" <pseudo@colocall.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs one user DoS?
Message-ID: <20031006192900.GA18447@linuxhacker.ru>
References: <20031004120625.GA41175@colocall.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031004120625.GA41175@colocall.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Oct 04, 2003 at 03:06:25PM +0300, Max A. Krasilnikov wrote:
> I have found such strange thing:
> pseudo@avalon at 14:04:00  ~> dd if=/dev/zero of=file bs=1 count=0 seek=1000000000000
> After that my Intel Celeron 800 MHz/384M RAM 60G/Seagate U6 under
> Linux-2.4.22-grsec on reiserfs was utilized 100% for more than 2 hours.
> dd process can't be killed.
> Is this my flow or real bug?

This particular problem is fixed in current 2.4 bk tree (and the fix
will be in 2.4.23). Also this problem does not exist in 2.6 for some time now.

Bye,
    Oleg
