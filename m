Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSFCUZM>; Mon, 3 Jun 2002 16:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSFCUZL>; Mon, 3 Jun 2002 16:25:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36619 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315483AbSFCUZK>; Mon, 3 Jun 2002 16:25:10 -0400
Date: Mon, 3 Jun 2002 22:25:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: do_mmap
Message-ID: <20020603202513.GB28911@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020603121943.A37@toy.ucw.cz> <Pine.GSO.4.05.10206032153260.7433-100000@mausmaki.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> do_brk() is _never_ checked for return (at least in binfm_elf) ... oh
> well ...

That's the bug I had in my mind. It actually bitten me.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
