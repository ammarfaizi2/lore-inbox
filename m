Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTJ3ElL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 23:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTJ3ElL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 23:41:11 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:38157 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262127AbTJ3ElJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 23:41:09 -0500
Date: Thu, 30 Oct 2003 04:41:01 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>, <geert@linux-m68k.org>,
       <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Cursor problems still in test9
In-Reply-To: <20031028094907.GA1319@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310300436440.28721-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi!
> 
> [And they get worse in fbcon-test patches I tried].
> 
> Try this on 2.4 (with vesafb).
> 
> echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"
> 
> ...then try it on 2.6, type foo in bash then delete it using
> backspace; ghost cursors stay there. Run emacs and quit it (it sets
> cursor to very visible). Boom, special cursor settings are gone.

I experimented with the above. I tried it out on vgacon, fbcon 2.4.X and 
fbcon 2.6.X. All give different results. What are suppose to see? 
 
> And now, use gpm on text console to select some text. Hold down left
> button, move mouse a bit. Sometimes cursor gets corrupted and stays
> there.

Will try.

