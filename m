Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312256AbSDEIBk>; Fri, 5 Apr 2002 03:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312361AbSDEIBb>; Fri, 5 Apr 2002 03:01:31 -0500
Received: from albireo.ucw.cz ([194.213.206.36]:9732 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S312256AbSDEIBS>;
	Fri, 5 Apr 2002 03:01:18 -0500
Date: Fri, 5 Apr 2002 10:01:15 +0200
From: Martin Mares <mj@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
Message-ID: <20020405080115.GA409@ucw.cz>
In-Reply-To: <m11ydwu5at.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Instead removes the assumption the code is linked to run at 0.  The
> binary code is already PIC, this makes the build process the same way,
> making the build requirements more flexible. 

What are the reasons to do this change? The assumption that "linked at 0"
assumptions looks pretty harmless and the "-start"'s everywhere are ugly.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Lottery -- a tax on people who can't do math.
