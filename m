Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291161AbSAaRTe>; Thu, 31 Jan 2002 12:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291163AbSAaRTY>; Thu, 31 Jan 2002 12:19:24 -0500
Received: from bitmover.com ([192.132.92.2]:19124 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291161AbSAaRTP>;
	Thu, 31 Jan 2002 12:19:15 -0500
Date: Thu, 31 Jan 2002 09:19:14 -0800
From: Larry McVoy <lm@bitmover.com>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Rob Landley <landley@trommello.org>, Larry McVoy <lm@bitmover.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131091914.L1519@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Troy Benjegerdes <hozer@drgw.net>,
	Rob Landley <landley@trommello.org>, Larry McVoy <lm@bitmover.com>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Eli Carter <eli.carter@inet.com>,
	Georg Nikodym <georgn@somanetworks.com>,
	Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130195154.R22323@work.bitmover.com> <20020131002355.X14339@altus.drgw.net> <20020130223711.L18381@work.bitmover.com> <20020131074924.QZMB10685.femail14.sdc1.sfba.home.com@there> <20020131111337.Y14339@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020131111337.Y14339@altus.drgw.net>; from hozer@drgw.net on Thu, Jan 31, 2002 at 11:13:37AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 11:13:37AM -0600, Troy Benjegerdes wrote:
> Can you detect the 'collapsed vs full version' thing, and force it to be 
> a merge conflict? That, and working LOD support would probably get most 
> of what I want (until I try the new version and find more stuff I want 
> :P)

Are you sure you want that?  If so, that would work today, it's about a
20 line script.  You clone the tree, collapse all the stuff into a new
changeset, and pull.  It will all automerge.  But now you have the detailed
stuff and the non-detailed stuff in the same tree, which I doubt is what
you want.  I thought the point was to remove information, not double it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
