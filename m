Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbTAWOMa>; Thu, 23 Jan 2003 09:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbTAWOMa>; Thu, 23 Jan 2003 09:12:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34316 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265246AbTAWOM3>; Thu, 23 Jan 2003 09:12:29 -0500
Date: Thu, 23 Jan 2003 15:21:38 +0100
From: Martin Mares <mj@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, trivial@rustcorp.com.au,
       Neil Brown <neilb@cse.unsw.edu.au>, dwmw2@redhat.com
Subject: Re: [PATCH] [TRIVIAL] kstrdup
Message-ID: <20030123142138.GA2031@atrey.karlin.mff.cuni.cz>
References: <20030119233750.GA674@elf.ucw.cz> <20030123063701.1F7172C2E0@lists.samba.org> <20030123140215.GA1229@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123140215.GA1229@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Ehm?! What's confusing on strdup? Or you want to also introduce
> kmemcpy, kmemcmp, ksprintf etc?

No, as long as they don't allocate any memory.

"kstrdup" makes it clear that the string is allocated by kmalloc()
and should be freed by kfree().

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"In theory, practice and theory are the same, but in practice they are different." -- Larry McVoy
