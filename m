Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbRGFVLa>; Fri, 6 Jul 2001 17:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266381AbRGFVLU>; Fri, 6 Jul 2001 17:11:20 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:32165 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S263089AbRGFVLJ>; Fri, 6 Jul 2001 17:11:09 -0400
Date: Fri, 6 Jul 2001 14:08:47 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: Tim McDaniel <tim.mcdaniel@tuxia.com>
cc: <linux-ppc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Trouble Booting Linux PPC On Mac G4 2000
In-Reply-To: <A16915712C18BD4EBD97897F82DA08CD409EEE@exchange1.win.agb.tuxia>
Message-ID: <Pine.LNX.4.33.0107061407500.22870-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Jul 2001, Tim McDaniel wrote:

>
> We are having a great degree of difficulty getting Linux PPC20000
> running on a Mac G4 466 tower with 128MB of memory, One 30MB HD and one
> CR RW. This is not a NuBus based system. To the best of our knowledge we
> have followed the user manual to the tee, and even tried forcing video
> settings at the Xboot screen.
>
>
> But still, when we encounter the screen where you must chose between
> MacOS and Linux and we chose linux, the screen goes black and for all
> practical purposes the box appears to be locked.   We've also tried
> editing yaboot.conf but can't seem to save the new file.
>
> Any help would be greatly appreatiated.

add "video=ofonly" to your boot command line.  That is, at the yaboot
"boot: " prompt, type "linux video=ofonly"

If that doesn't work, try something else :)

-jwb

