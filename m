Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbTCGAxz>; Thu, 6 Mar 2003 19:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261311AbTCGAxz>; Thu, 6 Mar 2003 19:53:55 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:61969 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S261310AbTCGAxy>;
	Thu, 6 Mar 2003 19:53:54 -0500
Date: Thu, 6 Mar 2003 18:04:22 -0700
From: Val Henson <val@nmt.edu>
To: Steven Cole <elenstev@mesatop.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Those ruddy punctuation fixes
Message-ID: <20030307010422.GI26725@boardwalk>
References: <20030305111015.B8883@flint.arm.linux.org.uk> <20030305122008.GA4280@suse.de> <1046920285.3786.68.camel@spc1.mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046920285.3786.68.camel@spc1.mesatop.com>
User-Agent: Mutt/1.4i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 08:11:11PM -0700, Steven Cole wrote:
> 
> That is why I was very careful with my its -> it's patch.
> In the two files where an extra apostrophe would have broken
> the build, I changed its to it is.  Why not just leave it alone?
> Because some well-meaning spelling fixer may come along in the
> future and break it, just like in proc-fns.h.

Wait, this sounds like a conversation with the Mafia:

"Pay us protection money."
"Why do we need to pay you for protection?"
"So we can protect you from criminals like ourselves."

I'd rather solve this problem by making standalone spelling fixes and
other cosmetic changes taboo.  Cosmetic changes combined with actual
useful code changes are fine with me.  If you're risking breaking the
build, there should be some benefit that justifies the risk.

Consider this a vote against standalone spelling/typo patches.

-VAL (normally a total pedant about spelling and grammar)
