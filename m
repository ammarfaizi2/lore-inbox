Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbTBQSES>; Mon, 17 Feb 2003 13:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBQSES>; Mon, 17 Feb 2003 13:04:18 -0500
Received: from terminus.zytor.com ([63.209.29.3]:18143 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S267253AbTBQSEQ>; Mon, 17 Feb 2003 13:04:16 -0500
Message-ID: <1911.212.181.176.76.1045505249.squirrel@www.zytor.com>
Date: Mon, 17 Feb 2003 10:07:29 -0800 (PST)
Subject: Re: [RFC] klibc for 2.5.59 bk
From: "H. Peter Anvin" <hpa@zytor.com>
To: <sam@ravnborg.org>
In-Reply-To: <20030217180246.GA26112@mars.ravnborg.org>
References: <20030209125759.GA14981@kroah.com>
        <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu>
        <20030217180246.GA26112@mars.ravnborg.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <kai@tp1.ruhr-uni-bochum.de>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>, <hpa@zytor.com>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Feb 16, 2003 at 09:06:09PM -0600, Kai Germaschewski wrote:
>
>> I did some work on integrating klibc into kbuild now. I used your
>> patch as  guide line, though I started from scratch with klibc-0.77.
>> The build  should work fine (reminder: "make KBUILD_VERBOSE=0 ..."
>> will give you much  more readable output), but I probably broke some
>> non-x86 architectures  in the process.
>
> Got this output when compiling user programs:
>   USERCC  usr/lib/snprintf.o
> cc1: warning: -malign-loops is obsolete, use -falign-loops
> cc1: warning: -malign-jumps is obsolete, use -falign-jumps
> cc1: warning: -malign-functions is obsolete, use -falign-functions
>

I get the same error compiling the kernel proper for Crusoe.  This is what
I like to call an "annoyance warning" where maintaining compatibility
between gcc versions emit a neverending stream of annoying messages.

    -hpa



