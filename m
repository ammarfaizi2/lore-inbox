Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265318AbSKAQk3>; Fri, 1 Nov 2002 11:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSKAQk3>; Fri, 1 Nov 2002 11:40:29 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:11516 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265318AbSKAQk2>; Fri, 1 Nov 2002 11:40:28 -0500
Date: Fri, 1 Nov 2002 09:40:05 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Christoph Hellwig <hch@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK console] console updates.
In-Reply-To: <20021030215258.A10037@infradead.org>
Message-ID: <Pine.LNX.4.33.0211010937050.6296-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Oct 30, 2002 at 01:56:38PM -0800, James Simmons wrote:
> > I doubt this code will go into 2.5.X but it is avaiable for anyone to play
> > with it.
>
> Why?  I don't want to live another release with the old, crappy console,
> and you've been working on this during almost all of 2.4 now..

Give my console diff a try.

http://phoenix.infradead.org/~jsimmons/console.diff.gz

Its against 2.5.45. It has 3 bugs I know of.

1) Switch back to X messes up the screen.

2) I had to disable the beeper. I have to think of a proper solution to
   that problem with Vojtech.

3) Software suspend is broken because the console has moved from the
   global int currcons to private struct vc_data to represent a VC.
   BTW what was the author of that code trying to do any ways?


