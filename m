Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276552AbRI2Qkw>; Sat, 29 Sep 2001 12:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276547AbRI2Qkg>; Sat, 29 Sep 2001 12:40:36 -0400
Received: from netcore.fi ([193.94.160.1]:37906 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S276544AbRI2QkT>;
	Sat, 29 Sep 2001 12:40:19 -0400
Date: Sat, 29 Sep 2001 19:40:27 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Ingo Molnar <mingo@elte.hu>
cc: "Randy.Dunlap" <rddunlap@osdlab.org>,
        Andreas Dilger <adilger@turbolabs.com>, <linux-kernel@vger.kernel.org>,
        <linux-net@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0109291936500.17020-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2001, Ingo Molnar wrote:
> (i can see where the confusion comes from, 'syslog servers' are ones that
> receieve syslogs. It's a backwards term i think. 'netconsole servers' are
> the ones that produce the messages.)

Speaking of which, would it be too big a burden (or is it supported
already), that the oopses or dumps would be sent off to an off-link syslog
server?

This would ease the use in occasions where you don't expect a crash (ie:
no listener in local network), but do log on remote syslogd's
considerably.

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords


