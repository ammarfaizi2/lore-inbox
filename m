Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSE0S0g>; Mon, 27 May 2002 14:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316719AbSE0S0f>; Mon, 27 May 2002 14:26:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64270 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316709AbSE0S0f>; Mon, 27 May 2002 14:26:35 -0400
Date: Mon, 27 May 2002 11:25:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jan Kara <jack@suse.cz>
cc: dalecki@evision-ventures.com,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 1/2 Quota changes
In-Reply-To: <20020527130413.GA17926@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0205271122390.3172-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 May 2002, Jan Kara wrote:
>
>   here I'm sending a bit altered (finally I decided to add 'version'
> field) Martin's patch which moves quota info from proc to sysctl...
> Please apply.

Well, Martin's patch is already in 2.5.18.

Also, I really don't like version numbers - that only shows that the
author _designed_ for crap. I would suggest either:

 - no version number, and just confidence that you won't need any more
   statistics.

 - no version number, and a file layout that is inherently expandable (or
   rather: multiple files with clear names, one value per file).

There just is never any excuse to add version numbers, that just later on
acts as an excuse for being sloppy.

		Linus

