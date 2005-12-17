Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVLQASm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVLQASm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 19:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVLQASm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 19:18:42 -0500
Received: from [139.30.44.16] ([139.30.44.16]:11857 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S964791AbVLQASm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 19:18:42 -0500
Date: Sat, 17 Dec 2005 01:18:38 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Vladimir Lazarenko <vlad@lazarenko.net>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: tulip on alpha ds10l 100MbpsFD problem
In-Reply-To: <A77AD032-AA74-4F2E-B393-F18528BBEC81@lazarenko.net>
Message-ID: <Pine.LNX.4.63.0512170110430.30990@gockel.physik3.uni-rostock.de>
References: <A77AD032-AA74-4F2E-B393-F18528BBEC81@lazarenko.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2005, Vladimir Lazarenko wrote:

> Hello,
> 
> I'm trying to get this DS 10L going with Linux, and I hit the ceiling with the
> onboard ethernet.
> Whenever the device is in 10Mbps, and switch is in 10 Mbps, everything works
> ok (half-duplex mode). Whenever I switch to 100Mbps, I'm not able to receive
> packets. At all. Sending goes ok, i.e. I see DHCP requests on another server,
> but nothing reaches the box when data is sent to it.
> 
> Similar behaviour with both de4x5 and tulip drivers.

Try to connect them to a different switch.

I had the same problem with some XP1000s some years ago. It went away when 
I connected them to a different switch. Since then, the machines have been 
on four different switches, and only had the problem with one of them. 
Strangely it was an expensive managed switch that didn't work, while two 
el cheapo 8 port switches had no problems. Somewhere I read this was a 
hardware bug of the cards.

Good luck!
Tim
