Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262998AbRE1Hfg>; Mon, 28 May 2001 03:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262999AbRE1HfZ>; Mon, 28 May 2001 03:35:25 -0400
Received: from [213.46.240.7] ([213.46.240.7]:47138 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S262998AbRE1HfL>; Mon, 28 May 2001 03:35:11 -0400
From: "Ben Twijnstra" <bentw@chello.nl>
To: linux-kernel@vger.kernel.org
Date: Mon, 28 May 2001 09:34:10 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.5-ac1 won't boot with 4GB bigmem option
Reply-to: Ben Twijnstra <bentw@chello.nl>
Message-ID: <3B121B92.18192.725C5@localhost>
In-Reply-To: <01052722010200.01106@beastie> from "Ben Twijnstra" at May 27, 2001 10:01:02 PM
In-Reply-To: <E1547yj-0002Mb-00@the-village.bc.nu>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

2.4.5-ac2 works fine with 4GB on. Thanks! Will try a 2.4.5-aa2 later 
today, just for fun.

Grtz,


Ben

On 27 May 2001, at 22:21, Alan Cox wrote:

> > I compiled and booted the 2.4.5-ac1 kernel with the CONFIG_HIGHMEM4G=y option 
> > and got an oops in __alloc_pages() (called by alloc_bounce() called by 
> > schedule()). Everything works fine if I turn the 4GB mode off.
> > Machine is a Dell Precision with 2 Xeons and 2GB of RAM.
> > 
> > 2.4.5 works fine with the 4GB. Any idea what changed between the two?
> 
> The -ac tree has some VM differences for bigmem that really need to be
> cleaned up and/or removed now the Linus tree is looking solid. I'll probably
> drop those diffs for -ac2 so that folks are working against one set of VM
> 

