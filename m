Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290590AbSA3U5h>; Wed, 30 Jan 2002 15:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290591AbSA3U51>; Wed, 30 Jan 2002 15:57:27 -0500
Received: from [212.176.242.127] ([212.176.242.127]:6921 "EHLO
	penguin.aktivist.ru") by vger.kernel.org with ESMTP
	id <S290590AbSA3U5P>; Wed, 30 Jan 2002 15:57:15 -0500
Date: Wed, 30 Jan 2002 23:57:02 +0300
From: Wartan Hachaturow <wart@softhome.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console driver behaviour?
Message-ID: <20020130235702.A23358@penguin.aktivist.ru>
In-Reply-To: <20020130162536.GA12421@mojo.spb.ru> <Pine.LNX.4.33.0201301508480.23104-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201301508480.23104-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 03:09:07PM -0500, Mark Hahn wrote:

> > any way to catch the situation? I've thought that open should
> > return ENODEV in these cases, but it doesn't..
> 
> screen, perhaps?  this is most definitely not a linux-kernel question.

This is most probably a console driver question, which is
kernel-specific ;)
I wonder what should console driver say when it doesn't have a real physical
console behind it. IMO, this should be a ENODEV case, or some other way
to determine programmatically that this situation takes place.
So, I am trying to find someone familar with console driver on
linux-kernel (since this driver doesn't have a specific maintainer).

If I am wrong, and linux-kernel is not relevant, sorry..

-- 
Regards, Wartan.
echo "Your stdio isn't very std." 
		-- Larry Wall in Configure from the perl distribution

