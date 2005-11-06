Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVKFWUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVKFWUV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVKFWUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:20:21 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:35759 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP id S932358AbVKFWUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:20:20 -0500
Date: Sun, 6 Nov 2005 14:20:12 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Chip Salzenberg <chip@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hostap interrupt problems, maintainers unresponsive - "wifi0: interrupt delivery does not seem to work"
Message-ID: <20051106222012.GS9194@jm.kir.nu>
References: <20051102174639.GB6816@tytlal.topaz.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102174639.GB6816@tytlal.topaz.cx>
User-Agent: Mutt/1.5.8i
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 09:46:39AM -0800, Chip Salzenberg wrote:

> I've sent this problem description to the upstream maintainers three
> times and received no reply, let alone illumination.  Thus:

You may need to re-adjust your believes that everyone is working 24/7
just waiting for your questions and providing immediate solutions for
whatever you may come up with. Let's just say that some of your messages
on the Host AP mailing list were not exactly best way of getting people
interested in using any time to help you.

I happen to work on Host AP driver mainly during weekends and you left
gracious Mon-Thu (or well, Mon-Tue based on this message) time to react
before starting to complain loudly that no one is helping with your
problem. Actually, I did answer your message as soon as I read it on
Friday.

> Hostap 0.3.9 under kernel 2.6.12 works fine with the D-Link DWL-650.

Can you test whether the current development version (0.4.6) works with
2.6.12? What about 2.6.13?

> Hostap 0.4.4-kernel, included with kernel 2.6.14, does not work; nor
> do versions 0.3.9 nor 0.4.1 compiled separately against 2.6.14.  There
> seems to be a problem with interrupt delivery.  Soon after the module
> is installed, keystrokes and all other interrupt-driven activity pause
> periodically for a LONG time (on the order of five seconds).
> Keystrokes will often auto-repeat because the key-raise interrupt gets
> delayed and the kernel thinks the key is still down.

I cannot reproduce this in my test setup. Linux 2.6.14 with the Host AP
driver works on my IBM ThinkPad T43 with hostap_cs and the same station
firmware version that you seem to be using (1.8.4). Did you need to do
something with the card before seeing this issue apart from plugging it
in? I was able to associate with WPA without seeing any problems.

Are you using the new hotplug mechanism to initialize PC Card modules?
Can you please send full dmesg output including everything from the
kernel startup to the point when hostap_cs starts reporting problems?

-- 
Jouni Malinen                                            PGP id EFC895FA
