Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287332AbSAQAfX>; Wed, 16 Jan 2002 19:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286557AbSAQAfO>; Wed, 16 Jan 2002 19:35:14 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:36025 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S286944AbSAQAfF>; Wed, 16 Jan 2002 19:35:05 -0500
To: Ben Clifford <benc@hawaga.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
In-Reply-To: <Pine.LNX.4.33.0201161018460.1758-100000@barbarella.hawaga.org.uk>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: 17 Jan 2002 01:34:44 +0100
Message-ID: <87ofjtizmj.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Clifford <benc@hawaga.org.uk> writes:

> The port 53 bindings happen without problem.
> 
> BINDv9 has a lightweight resolver service which runs on port 921 - this is
> not enabled by default, and when it is enabled, seems to start up later on
> in the startup process.

Ok, I'm running BINDv8 right now.

> > You may use accessfs and capabilities in parallel, of course. But
> > currently, this is equivalent to "chown root/chmod u+x".
> 
> Taking capabilities away seems to break backwards compatibility.

I'll think about this. I haven't heard about a working system or tools,
which use capabilities yet. So I thought, nobody would see a difference.

> And I'm not entirely sure it *is* equivalent to chown root/chmod u+x -
> that is how /mnt/accessfs/net/ipv4/bind appeared and my named couldn't
> bind to 921.

I will investigate this further. Seems, I need to install BINDv9 to
reproduce this problem.

Regards, Olaf.
