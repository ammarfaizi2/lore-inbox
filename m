Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317342AbSGTEF7>; Sat, 20 Jul 2002 00:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317343AbSGTEF7>; Sat, 20 Jul 2002 00:05:59 -0400
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:18695 "EHLO
	Midgard.attbi.com") by vger.kernel.org with ESMTP
	id <S317342AbSGTEF7> convert rfc822-to-8bit; Sat, 20 Jul 2002 00:05:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/9] 2.5.6 lm_sensors
Date: Fri, 19 Jul 2002 23:08:54 -0500
User-Agent: KMail/1.4.2
References: <Pine.LNX.4.44.0207192224280.1120-100000@waste.org>
In-Reply-To: <Pine.LNX.4.44.0207192224280.1120-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207192308.54936.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anything short of "Destroy my precious Thinkpad? [y/N]"
> probably is insufficient. Frankly, I don't think even that's
> enough. Once this is mainlined, someone will want to build a
> kitchen sink distro kernel with sensor support and if the code
> itself isn't autodetecting whether it's on a problematic
> platform, it won't be long before someone boots their Thinkpad
> off a friend's CDR and toasts it.

I agree, the lm_sensors driver should maintain a blacklist for 
ThinkPads, and make it possible to disable the blacklist only by 
going in and hacking the kernel source manually.  Whenever the 
lm_sensors drivers detect a blacklisted ThinkPad, they should 
vehemently refuse to function.

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

