Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283323AbRK2Qkk>; Thu, 29 Nov 2001 11:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283322AbRK2Qka>; Thu, 29 Nov 2001 11:40:30 -0500
Received: from [216.151.155.121] ([216.151.155.121]:55056 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S283320AbRK2QkV>; Thu, 29 Nov 2001 11:40:21 -0500
To: "Rajasekhar Inguva" <irajasek@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Routing table problems
In-Reply-To: <OFAC45A406.7118A3A7-ON65256B31.00430A0D@in.ibm.com>
From: Doug McNaught <doug@wireboard.com>
Date: 29 Nov 2001 11:40:12 -0500
In-Reply-To: "Rajasekhar Inguva"'s message of "Sat, 29 Dec 2001 17:44:08 +0530"
Message-ID: <m3snaxledv.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rajasekhar Inguva" <irajasek@in.ibm.com> writes:

> Hi All, In continuation to my earlier report ...
> 
> The problem is only seen with the default gateway entry.
> 
> The gateway entry for my subnet is also deleted during a 'down', but is
> restored properly after an 'up' .

The default gateway route is installed at boot time by a separate
'route' command.  'ifconfig' can derive your subnet route from the
address and mask of the interface, but it can't magically determine
your default gateway.  Add it yourself using "route" or "ip" or rerun
your network start scripts.

In short, "Working as Designed".

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
