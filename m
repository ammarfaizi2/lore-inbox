Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274068AbRISOVI>; Wed, 19 Sep 2001 10:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274069AbRISOU6>; Wed, 19 Sep 2001 10:20:58 -0400
Received: from alex.intersurf.net ([216.115.129.11]:13841 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S274068AbRISOUr>; Wed, 19 Sep 2001 10:20:47 -0400
Date: Wed, 19 Sep 2001 09:21:09 -0500
From: Mark Orr <markorr@intersurf.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.10p12 net/netsyms.c -- unresolved symbol tty_register_ldisc
Message-Id: <20010919092109.2ea5f89c.markorr@intersurf.com>
In-Reply-To: <Pine.LNX.4.33.0109190912060.32717-200000@viper.haque.net>
In-Reply-To: <Pine.LNX.4.33.0109190912060.32717-200000@viper.haque.net>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.8; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001 09:14:19 -0400 (EDT)
"Mohammad A. Haque" <mhaque@haque.net> wrote:

> One liner fix for unresolved symbol in PPP

With this fix, it compiles.  But in using the PPP modules
I find that it doesnt work -- the modem hangs up as soon as
connect is made.  /var/log/messages reports:

Sep 19 09:11:27 darkstar insmod: /lib/modules/2.4.10-pre12/kernel/drivers/net/ppp_async.o: insmod tty-ldisc-3 failed

--
Mark Orr
markorr@intersurf.com

