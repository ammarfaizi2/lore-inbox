Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSJNVqA>; Mon, 14 Oct 2002 17:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262192AbSJNVqA>; Mon, 14 Oct 2002 17:46:00 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:30626 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262190AbSJNVp7>; Mon, 14 Oct 2002 17:45:59 -0400
Message-Id: <200210142151.g9ELpiLE101376@pimout1-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Mon, 14 Oct 2002 12:33:59 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210132242.g9DMgVng334662@pimout3-ext.prodigy.net> <3DAA0708.1030701@namesys.com>
In-Reply-To: <3DAA0708.1030701@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 October 2002 07:51 pm, Hans Reiser wrote:

> Call it forcedumount().
>
> What apps need to know about how to call it besides umount anyway?
>
> Not a lot that need a lot of worry.....

Actually, looking at the umount.c user space app thingy, it turns out there's 
a umount2() glibc call that doesn't have a man page associated with it.  
(Suspected there might be, since the existing -f had to get into the kernel 
some how...)

The new patch Hugh Dickens posted looks interesting, but of course real life 
has decided to intrude for a couple of days, looks like... :)

> Hans

Rob

