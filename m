Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWCLCiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWCLCiz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 21:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWCLCiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 21:38:54 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52661
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750794AbWCLCiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 21:38:54 -0500
Date: Sat, 11 Mar 2006 18:39:04 -0800 (PST)
Message-Id: <20060311.183904.71244086.davem@davemloft.net>
To: michal.k.k.piotrowski@gmail.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Linux v2.6.16-rc6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <6bffcb0e0603111751i1ed30794s@mail.gmail.com>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
	<6bffcb0e0603111751i1ed30794s@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Date: Sun, 12 Mar 2006 02:51:40 +0100

> I have noticed this warnings
> TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
> 148470938:148470943. Repaired.
> TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
> 148470938:148470943. Repaired.
> TCP: Treason uncloaked! Peer 82.113.55.2:11759/59768 shrinks window
> 1124211698:1124211703. Repaired.
> TCP: Treason uncloaked! Peer 82.113.55.2:11759/59768 shrinks window
> 1124211698:1124211703. Repaired.
> 
> It maybe problem with ktorrent.

It is a problem with the remote TCP implementation, it is
illegally advertising a smaller window that it previously
did.
