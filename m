Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbSLFXng>; Fri, 6 Dec 2002 18:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267663AbSLFXnf>; Fri, 6 Dec 2002 18:43:35 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:63755 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267662AbSLFXna>; Fri, 6 Dec 2002 18:43:30 -0500
Date: Fri, 6 Dec 2002 23:51:05 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Tobias Rittweiler <inkognito.anonym@uni.de>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re[2]: [STATUS] fbdev api.
In-Reply-To: <15835232027.20021206235940@uni.de>
Message-ID: <Pine.LNX.4.44.0212062350030.10225-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> AD> Do you have framebuffer console enabled but with no framebuffer device
> AD> enabled at boot time?  This will always fail with James' current patch.
> 
> AD> The diff I submitted in one of my replies in this thread (fbcon.diff)
> AD> might fix that (not sure).
> 
> Thanks, that patches fixes it.

The fix is in the latest BK tree as well so Linus will get the fix :-)

> >> b) After returning from blanking mode (via APM) to normal mode, no
> >>    character is drawn. Let's assume I'm using VIM when that happens:
> >>    After putting any character to return from blank mode, the screen stays
> >>    blanked apart from the cursor that _is_ shown. Now I'm able to move
> >>    the cursor, and when the cursor encounters a character, this char
> >>    is drawn (and keeps drawn). Though when I press Ctrl-L or when I go one line
> >>    above to the current top-line (i.e. by forcing a redrawn), the
> >>    whole screen is drawn properly.
> >> 
> AD> Can you try this?
> AD> [..diff..]
>
> Yes, it fixes the problem, thanks.

Will apply.

> AD> the problem disappears, so I thought this was an isolated case with my
> AD> setup :-). Similar glitches happen also in emacs with syntax
> AD> highlighting turned on.
> 
> Still there.

 ????


