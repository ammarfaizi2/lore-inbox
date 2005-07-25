Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVGYMQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVGYMQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 08:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVGYMQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 08:16:50 -0400
Received: from styx.suse.cz ([82.119.242.94]:27090 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261231AbVGYMQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 08:16:49 -0400
Date: Mon, 25 Jul 2005 14:16:44 +0200
From: Jiri Benc <jbenc@suse.cz>
To: ricardo.b@zmail.pt
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [BUG] Tulip for ULi M5263: No packets transmitted
Message-ID: <20050725141644.66ba4021@griffin.suse.cz>
In-Reply-To: <1122146524.7275.22.camel@localhost>
References: <1122146524.7275.22.camel@localhost>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2005 20:22:04 +0100, Ricardo Bugalho wrote:
> the tulip driver isn't work out for my ULi M5263 network adapter.
> The driver loads and the interface receives packets but it won't
> transmit any. Running a packet capture on it shows no outbound packets,
> so I guess the driver thinks the card is screwed up and can't transmit.

Does tulip-fixes-for-uli5261.patch from -mm tree help?

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/broken-out/tulip-fixes-for-uli5261.patch


-- 
Jiri Benc
SUSE Labs
