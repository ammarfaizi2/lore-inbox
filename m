Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVLETM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVLETM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVLETMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:12:25 -0500
Received: from styx.suse.cz ([82.119.242.94]:55246 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932517AbVLETMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:12:24 -0500
Date: Mon, 5 Dec 2005 20:11:58 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@nospam.otaku42.de, mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051205201158.7cae7c86@griffin.suse.cz>
In-Reply-To: <43948CC8.6000107@pobox.com>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	<20051205190038.04b7b7c1@griffin.suse.cz>
	<1133806444.4498.35.camel@gimli>
	<43948B13.2090509@pobox.com>
	<20051205194923.3b868d50@griffin.suse.cz>
	<43948CC8.6000107@pobox.com>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005 13:54:00 -0500, Jeff Garzik wrote:
> Complete bullshit.  There is obviously 802.11 generic code in the 
> kernel, and that's what _I_ am saying, because it's true.
> 
> If it doesn't support your favorite wireless chipset, then submit patches.

I have no favorite chipset. I read tons of source code of different
drivers instead. Current 802.11 code supports no management stuff at
all. And nearly every driver needs support for it - ask any developer of
wireless driver except James Ketrenos (oh, wait a moment - although ipw
devices do, unlike other devices, a lot of work in firmware, he is
implementing in the driver some management stuff too - strange, is not
his own "stack" good enough even for himself?).

And, as you might notice, I sent many patches. Only minor ones were
accepted. And then I started (and attended) a debate among wireless
developers about concepts of 802.11 stack, do you remember? And it gave
us interesting results. That results were implemented (patches were sent
and not accepted).

It may appears that I stopped afterwards, but it is not true. Nearly
after that debate had finished, Jouni announced opensourcing of the
stack he has been working on for several years. From that time I have
been trying to get familiar with that stack, it is quite complex. I have
one semi-working driver for it now and I think I know about issues of
the stack.


-- 
Jiri Benc
SUSE Labs
