Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbREOQWo>; Tue, 15 May 2001 12:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261926AbREOQWf>; Tue, 15 May 2001 12:22:35 -0400
Received: from smarty.smart.net ([207.176.80.102]:53521 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S261921AbREOQWU>;
	Tue, 15 May 2001 12:22:20 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200105151626.MAA16354@smarty.smart.net>
Subject: Re: LANANA: Getting out of hand?
To: linux-kernel@vger.kernel.org
Date: Tue, 15 May 2001 12:26:21 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torvalds sez
>On Mon, 14 May 2001, Alan Cox wrote:
>>
>> Except that Linus wont hand out major numbers, which means I can't even boot
>> simply off such a device. I bet the vendors in question dont think the sun
>> shines out of linus backside any more.
>
>Actually, it does. It's just that some people have gotten so blinded by my
>a** that they can no longer see it any more ;)
>
>The problem I have is that there are lots of _good_ solutions, but they
>all imply a bit more work than the bad ones.
>
>What does that result in? Everybody continues to use the simple old setup,
>which required no thought at all, but that is a pain to maintain.
>
>For example, the only thing you need in order to boot is to have a nice
>clean "disk" major number. That's it. Nothing fancy, nothing more.

To what extent do the code of the various drivers reflect that? i.e. is there
some code that is common to all block devices, and that is used by code that 
is common to all disk devices, that further is used by all drivers pretending 
to be IDE devices, which is further used by all code pretending to be EIDE 
devices, etc. ?  If you look at majors, say, as a binary tree which you 
walk in accordance with the bits in the major, can drivers nest like that?

I've wondered about that for a long time for various reasons.

Rick Hohensee
www.clienux.com

