Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281194AbRKTR7v>; Tue, 20 Nov 2001 12:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281193AbRKTR7h>; Tue, 20 Nov 2001 12:59:37 -0500
Received: from dns.isp.htn.de ([193.254.18.42]:1755 "EHLO mail.htp-tel.de")
	by vger.kernel.org with ESMTP id <S281192AbRKTR70>;
	Tue, 20 Nov 2001 12:59:26 -0500
Date: Tue, 20 Nov 2001 13:24:49 +0100
From: Ingo Saitz <Ingo.Saitz@stud.uni-hannover.de>
To: linux-kernel@vger.kernel.org
Subject: Re: radeonfb bug: text ends up scrolling in the middle of tux.
Message-ID: <20011120132449.A13506@pinguin.subspace.exe>
In-Reply-To: <200111200133.fAK1XT2J000773@vulpine.ao.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111200133.fAK1XT2J000773@vulpine.ao.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 08:33:29PM -0500, Dan Merillat wrote:
> Ok, I've poked around but I can't find a penguin or tux bitmap to
> figure out why scrolling is so broken.  I've got to login blind and type
> reset to get the console back.  Needless to say, no kernel messages
> are readable after the mode-switch (they all overwrite themselves on
> a single line)

Yes, I encontered the same. See my previous message for a patch:

Message-ID: <20011118163244.A1100@pinguin.subspace.exe>
Subject: Debugging (?) output in 2.4.14 breaks radeon framebuffer

The offending code seems to have entered the kernel at 2.4.14,
2.4.13 was OK on my box.

    Ingo
-- 
Gzip is Evil!
 - Gzip is described in RCF 1952
 - 1+9+5+2 = 23 - 2*3
