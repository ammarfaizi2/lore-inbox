Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313826AbSDZL2s>; Fri, 26 Apr 2002 07:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313827AbSDZL2r>; Fri, 26 Apr 2002 07:28:47 -0400
Received: from [195.39.17.254] ([195.39.17.254]:26768 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313826AbSDZL2q>;
	Fri, 26 Apr 2002 07:28:46 -0400
Date: Fri, 26 Apr 2002 11:13:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Brian Gerst <bgerst@didntduck.org>,
        "H. Peter Anvin" <hpa@zytor.com>, ak@suse.de,
        linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
Message-ID: <20020426091341.GA497@elf.ucw.cz>
In-Reply-To: <20020424023249.B2756@dualathlon.random> <Pine.LNX.4.44.0204231909250.10866-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >	  Basically they should only deal with the
> > other operative systems now.
> 
> Yeah. And since the security hole is fairly small and insignificant in
> comparison to some others, I suspect that the main "other operating
> system" just won't care one way or the other.

*If* the other system uses fpu unit for memcpy, well, it may get
pretty big and significant.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
