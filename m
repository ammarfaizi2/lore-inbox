Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271869AbRIEIkb>; Wed, 5 Sep 2001 04:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271877AbRIEIkV>; Wed, 5 Sep 2001 04:40:21 -0400
Received: from jabberwock.ucw.cz ([212.71.128.53]:38661 "EHLO
	jabberwock.ucw.cz") by vger.kernel.org with ESMTP
	id <S271869AbRIEIkA>; Wed, 5 Sep 2001 04:40:00 -0400
Date: Wed, 5 Sep 2001 10:40:08 +0200
From: Martin Mares <mj@ucw.cz>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: problem: pc_keyb.h
Message-ID: <20010905104008.I751@ucw.cz>
In-Reply-To: <3B8FE42B.23804609@pcsystems.de> <20010831213050.A3217@albireo.ucw.cz> <3B929F72.28BAF955@pcsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B929F72.28BAF955@pcsystems.de>; from nicos@pcsystems.de on Sun, Sep 02, 2001 at 11:06:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Martin, can't you add the line I sent in the last mail ?
> This would make it possible to include
> pc_keyb.h into many programs directly.

Please don't do that, user space programs depending on a particular version
of kernel headers have already created a horrible mess, so outside the cases
where you need to share a definition of some kernel<->userspace interface,
kernel headers really shouldn't be used outside the kernel.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Don't take life too seriously -- you'll never get out of it alive.
