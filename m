Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbSLNS2y>; Sat, 14 Dec 2002 13:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265797AbSLNS2y>; Sat, 14 Dec 2002 13:28:54 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:62082
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S265791AbSLNS2x>; Sat, 14 Dec 2002 13:28:53 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Mike Dresser <mdresser_l@windsormachine.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20021214100125.GA30545@suse.de>
References: <Pine.LNX.4.33.0212132319280.29293-100000@router.windsormachine.com>
	 <Pine.LNX.4.33.0212132345040.12319-100000@router.windsormachine.com>
	 <20021214100125.GA30545@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1039890995.17062.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 14 Dec 2002 12:36:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-14 at 04:01, Dave Jones wrote:
> On Fri, Dec 13, 2002 at 11:53:51PM -0500, Mike Dresser wrote:
>  > On Fri, 13 Dec 2002, Mike Dresser wrote:
>  > 
>  > > The single P4/2.53 in another machine can haul down in 3m17s
>  > >
>  > Amend that to 2m19s, forgot to kill a background backup that was moving
>  > files around at about 20 meg a second.



> Note that there are more factors at play than raw cpu speed in a
> kernel compile. Your time here is slightly faster than my 2.8Ghz P4-HT for
> example.  My guess is you have faster disk(s) than I do, as most of
> the time mine seems to be waiting for something to do.

An easy way to level the playing field would be to use /dev/shm to build
your kernel in. That way it's all in memory. If you've got a maching
with 512M, then it's easily accomplished.

> *note also that this is compiling stock 2.4.20 with default configuration.
> The minute you change any options, we're comparings apples to oranges.
> 
> 		Dave
