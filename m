Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262701AbTC0AJp>; Wed, 26 Mar 2003 19:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262704AbTC0AJp>; Wed, 26 Mar 2003 19:09:45 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:28936 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262701AbTC0AJo>; Wed, 26 Mar 2003 19:09:44 -0500
Date: Thu, 27 Mar 2003 00:20:54 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Torrey Hoffman <thoffman@arnor.net>
cc: Toplica Tanaskovic <toptan@EUnet.yu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [REPRODUCABLE BUGS] Linux 2.5.66
In-Reply-To: <1048722582.2039.11.camel@rohan.arnor.net>
Message-ID: <Pine.LNX.4.44.0303270019050.25001-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anyway the bug I see is:  If I use fbset to change between 1024x768,
> 800x600, and 640x480 the console doesn't seem to be aware of the
> change.  However, it doesn't seem to cause corruption or oops'es, at
> least for me so far.

Because the framebuffer can operate independent of the console now.try 
using stty for now. Fbset will have to be updated to the latest changes.

> However, I am pleased to say that I am able to use the sis framebuffer
> driver now.  Last time I tried, around 2.5.64 I think, I got serious
> screen corruption switching between X and the framebuffer console.
> 
> So things are getting better... thanks for all your work!

:-)

