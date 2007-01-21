Return-Path: <linux-kernel-owner+w=401wt.eu-S1751457AbXAUTtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXAUTtU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbXAUTtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:49:20 -0500
Received: from terminus.zytor.com ([192.83.249.54]:43629 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbXAUTtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:49:19 -0500
Message-ID: <45B3C3B4.6000706@zytor.com>
Date: Sun, 21 Jan 2007 11:49:08 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Junio C Hamano <junkio@cox.net>
CC: Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Announce] GIT v1.5.0-rc2
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>	<20070121134308.GA24090@1wt.eu> <7v7ivg1a25.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7v7ivg1a25.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
> 
> One worry I had about releasing git-1.5.0-rc2-1.rpm and friends
> just like the "official" ones was that people might have scripts
> to automate downloading & updating of packages, and they may not
> like to get "beta" installed for them.
> 
> I wonder if kernel.org machines are also affected...
> 

Put them in a different directory hierarchy if you don't want to make 
them installed.

>> I know it's a bit late to ask, but if new on-disk format changes, isn't
>> it time to bump the version to 2.0? It would be easier for many people to
>> remember that GIT 1.X uses format version 1 and that GIT 2.X uses format
>> version 2 with backwards compatibility with 1.X. I also think that 1.5
>> is much more different from 1.0 than a mid-term 2.0 would be from current
>> 1.5.
> 
> I think we could have gone either way (as you said, it is
> probably a bit too late to discuss this), but it should probably
> be Ok to stay at 1.X as long as these one-way-street format
> updates are turned off by default.
> 
> And the above happened way before this round and people have
> hopefully been happily using.  For example, v1.4.2 was done
> early August 2006.

In general, though, I would agree that the major number should change if 
there is an incompatible change.

	-hpa


