Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbUK0EJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbUK0EJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUK0EH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:07:58 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:6579 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S262277AbUKZTRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:17:06 -0500
Date: Thu, 25 Nov 2004 22:54:13 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Wenping Luo <wluo@fortinet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ethernet Via-rhine driver 1.1.17 duplex detection issue in linux kernel 2.4.25
Message-ID: <20041125215413.GC1843@k3.hellgate.ch>
References: <011801c4d270$cca65740$0101140a@fortinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011801c4d270$cca65740$0101140a@fortinet.com>
X-Operating-System: Linux 2.6.10-rc2 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004 13:58:58 -0800, Wenping  Luo wrote:
> I used crossed ethernet cable to connect one ethernet NIC to a Via Rhine III
> VT6105M NIC. I set the speed mode of Rhine Nic to be "auto" whereas I forced
> the peer NIC to be "100 Full Duplex". The Rhine NIC connected in mode of
> "100 Half Duplex" , instead of "100 Full Duplex", after detecting the peer.
> 
> I searched the Internet and I found another reported for similiar issue at
> http://lunar-linux.org/pipermail/lunar/2004-April/003894.html. However,
> there is no answer for this issue yet.

Does it work with 2.6.10-rc? Do other card/driver combinations correctly
detect the setting of your peer NIC?

Roger
