Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbUC2PC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUC2PC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:02:27 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:8968 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S262923AbUC2PCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:02:02 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: pdflush and dm-crypt
Date: Mon, 29 Mar 2004 17:01:56 +0200
User-Agent: KMail/1.6.1
References: <1067885681.20040329165002@nefty.hu>
In-Reply-To: <1067885681.20040329165002@nefty.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403291701.56694.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Monday 29 of March 2004 16:50, Zoltan NAGY napisa³:

> I've just upgraded the system to 2.6.5-rc2-bk6, and I'm using
> dm-crypt. It's a heavily used server, on average 20-30mbit/sec
> traffic is on the wire 7/24, and just noticed, that the load is very
> high. In every 4-5 sec pdflush takes a lot of cpu... Is this
> intentional? I've found a similar question on kerneltrap
> (http://kerneltrap.org/node/view/2756), but havent found a solution
> yet. I'm just wondering if it is a problem, or it's the normal
> behavior? It's a 1.8 P4 with 1G ram and highmem enabled, with 256 bit
> aes thru dm-crypt.
Same here (duron 1.2GHz, 512MB ram, IDE disks (via and promise controllers)) 
and it doesn't matter if I'm using cryptoloop or dm-crypt. 

System hangs for about one seconds (xmms stops playing, xterms are not 
responding to key presses) and then everything back to normal until next hang 
happens (in few seconds).

> Zoltan NAGY,
> Network Administrator

ps. I'm not sure (didn't do any checking to be sure) but afaik this started to 
happening with 2.6.3 kernel.
-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
