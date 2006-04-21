Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWDUAl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWDUAl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWDUAl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:41:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31135
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932184AbWDUAl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:41:26 -0400
Date: Thu, 20 Apr 2006 17:41:20 -0700 (PDT)
Message-Id: <20060420.174120.70279722.davem@davemloft.net>
To: torvalds@osdl.org
Cc: piet@bluelane.com, axboe@suse.de, diegocg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0604201512070.3701@g5.osdl.org>
References: <20060420193430.GH4717@suse.de>
	<1145569031.25127.64.camel@piet2.bluelane.com>
	<Pine.LNX.4.64.0604201512070.3701@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Thu, 20 Apr 2006 15:20:14 -0700 (PDT)

> I claim that Mach people (and apparently FreeBSD) are incompetent idiots. 
> Playing games with VM is bad. memory copies are _also_ bad, but quite 
> frankly, memory copies often have _less_ downside than VM games, and 
> bigger caches will only continue to drive that point home.

Yep.

And as I've documented several times on this list already, this
and research in that area is very well documented in standard
texts such as Networking Algorithmics by George Varghese,
particularly in Chapter 5 "Copying Data"

TLB games are dumb, just say no.
