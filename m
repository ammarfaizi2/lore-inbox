Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSLaRB1>; Tue, 31 Dec 2002 12:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSLaRB1>; Tue, 31 Dec 2002 12:01:27 -0500
Received: from s142-179-222-244.ab.hsia.telus.net ([142.179.222.244]:2298 "EHLO
	bluetooth.WNI.AD") by vger.kernel.org with ESMTP id <S263544AbSLaRB0>;
	Tue, 31 Dec 2002 12:01:26 -0500
Message-ID: <3E11CFD3.3070406@WirelessNetworksInc.com>
Date: Tue, 31 Dec 2002 10:11:47 -0700
From: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Re: Indention - why spaces?]
References: <3E11C4E2.2050306@WirelessNetworksInc.com> <20021231163154.GD9423@work.bitmover.com>
In-Reply-To: <20021231163154.GD9423@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Dec 2002 17:09:52.0207 (UTC) FILETIME=[6EC805F0:01C2B0EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that if you force people to use indent, by hooking it into the 
CVS commit script, they end up writing the code so that it looks exactly 
right and indent ends up doing nothing.  Somehow people also manage to 
learn what not to do, so that indent doesn't screw up!

The trouble with indent is that many combinations of switches causes it 
to screw up royally.  The documentation is also bad and outright wrong 
in some cases.  Once you managed to find a workable set of switches, it 
is mostly OK.  The few glitches are nothing to worry about, but to find 
the sweet spot can be tiresome.  However, once you got a proper config 
file that works for you, all your troubles are over, so it is worth 
while experimenting with it a bit.

Larry McVoy wrote:
>>Larry, you can save yourself a lot of trouble, time and money: Create an
>>indent configuration file and tell your people to use it.  That is
>>exactly why indent was written many years ago.
> 
> 
> Indent is fine as a first pass, it doesn't handle everything properly.
> If it did, I think I would have figured it out by now.  And no, I'm
> not going to go fix indent, I looked at the problems and the fixes 
> and decided to pass.  Some of them just aren't worth fixing in 
> indent.
> 
> Besides, I really don't believe in giving people crutches, I believe
> in teaching them what it is I want and why.  That tends to stick.


