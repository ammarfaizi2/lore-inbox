Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313201AbSC1R4G>; Thu, 28 Mar 2002 12:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313198AbSC1Rzz>; Thu, 28 Mar 2002 12:55:55 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:65164 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S313199AbSC1Rzm>; Thu, 28 Mar 2002 12:55:42 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 28 Mar 2002 10:01:15 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.7 IDE 27
In-Reply-To: <3CA2E2E4.4070603@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203280959520.1460-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Martin Dalecki wrote:

> Thu Mar 21 03:17:48 CET 2002 ide-clean-27
>
> - Make for less terse error messages in ide-tape.c.
>
> - Replaced all timecomparisions done by hand with all the proper timer_after()
>    commands.
>
> - Remove the drive niec1 mechanisms alltogether. There are several reasons for
>    this:

I did not have the time to test it Martin but looking at the code i'm
pretty confident that this is the cause of the ide_set_handler()/timer
problem on my box ...




- Davide


