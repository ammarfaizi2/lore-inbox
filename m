Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316572AbSE0Ke4>; Mon, 27 May 2002 06:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSE0Kez>; Mon, 27 May 2002 06:34:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41991 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316572AbSE0Key>; Mon, 27 May 2002 06:34:54 -0400
Date: Mon, 27 May 2002 12:34:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: swsusp for 2.5.18: kill broken Magic-D support
Message-ID: <20020527103455.GC23372@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020526185724.GA16004@elf.ucw.cz> <20020527155804.229232a1.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It is probably good idea to create rule that suspend may only be done
> > from process context... And it simplifies code a lot. Here's the
> > patch.
> 
> You could have it call "schedule_task" of course...

Yes, but it looks like it is easier to be killed. That feature is not keeping.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
