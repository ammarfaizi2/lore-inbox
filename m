Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267166AbTAFWsU>; Mon, 6 Jan 2003 17:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbTAFWsT>; Mon, 6 Jan 2003 17:48:19 -0500
Received: from ip68-0-152-218.tc.ph.cox.net ([68.0.152.218]:13199 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S267166AbTAFWsT>; Mon, 6 Jan 2003 17:48:19 -0500
Date: Mon, 6 Jan 2003 15:56:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Tomas Szepe <szepe@pinerecords.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
Message-ID: <20030106225652.GI796@opus.bloom.county>
References: <20030106212608.GQ5984@louise.pinerecords.com> <Pine.LNX.4.33L2.0301061359470.15416-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301061359470.15416-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 02:04:52PM -0800, Randy.Dunlap wrote:
> On Mon, 6 Jan 2003, Tomas Szepe wrote:
> 
> | > [rddunlap@osdl.org]
> |
> | > | |---------------------------------------------------------------------------
> | > | | I'd probably be happier if the current one didn't even _ask_ the user (or|
> | > | | only asked the user if kernel debugging is enabled), and just silently   |
> | > | | defaulted to the normal values.                                          |
> | > | |---------------------------------------------------------------------------
> | >
> | Randy,
> |
> | this looks correct to me.  Maybe using if/endif instead of the two
> | 'depends on' would make the entry more explicit to the eye of a future
> | beholder.
> 
> Hey Tomas,
> 
> Thanks for looking and giving me your comments.
> 
> if/endif would be useful there, especially if there was also an 'else'
> available...

I think that's by design (if / else is limiting, which is why you have a
very flexible depends syntax).  That looks exactly like what we do in
arch/ppc/Kconfig.  Maybe a comment 'tho to make it more explicit what's
being done and why would be in order here however.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
