Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315844AbSEEJJM>; Sun, 5 May 2002 05:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315845AbSEEJJL>; Sun, 5 May 2002 05:09:11 -0400
Received: from [195.39.17.254] ([195.39.17.254]:60563 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315844AbSEEJJK>;
	Sun, 5 May 2002 05:09:10 -0400
Date: Sun, 5 May 2002 00:24:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alternative API for raw devices
Message-ID: <20020504222453.GA110@elf.ucw.cz>
In-Reply-To: <Pine.GSO.4.21.0205011555450.12640-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> New option: CONFIG_RAW (tristate)
> 
> With that animal enabled you can say
> 
> # mount -t raw /dev/sda1 /dev/<whatever>

Are we going from "everything is a file" to everything is filesystem,
again?

Why not have /dev/sda1r from the beggining? Is this problem of not
enough majors?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
