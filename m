Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSL2SjL>; Sun, 29 Dec 2002 13:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSL2SjL>; Sun, 29 Dec 2002 13:39:11 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:10158 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261310AbSL2SjL>; Sun, 29 Dec 2002 13:39:11 -0500
To: Sebastian Abt <sebastian@sabt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch for null-interface?
References: <20021229140121.34f0fbf6.sebastian@sabt.net>
From: Andi Kleen <ak@muc.de>
Date: 29 Dec 2002 19:47:15 +0100
In-Reply-To: <20021229140121.34f0fbf6.sebastian@sabt.net>
Message-ID: <m3el80oe6k.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Abt <sebastian@sabt.net> writes:

> Is there any patch for null-interfaces like they exist in Cisco IOS
> available? I'm searching for sth like that to do null-routing, but
> google didn't find anything :/

I guess you mean an interface without an own IP address?  Just give it the 
IP address of some other interface, with a full (/32) netmask.
The kernel needs at least one IP address per router/host to start
local connections and give ICMP errors an source.

-Andi
