Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUEXVi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUEXVi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbUEXVi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:38:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:63126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263725AbUEXViz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:38:55 -0400
Date: Mon, 24 May 2004 14:38:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <Pine.LNX.4.58.0405241412550.4174@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0405241434250.32189@ppc970.osdl.org>
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0405241304580.4174@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0405241342190.32189@ppc970.osdl.org>
 <Pine.LNX.4.58.0405241412550.4174@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 May 2004, Davide Libenzi wrote:
> 
> That was what I was implying. Example:
> 
> me: Andrew this is the quit-smoking-patch-0.1.diff
> Andrew: Where's your signature? Go read Documentation/xxx and repost the signed version
> me: Oke doke. Reading ...
> me: There you go, here's quit-smoking-patch-0.2.diff with the required signature

Yes. On the other hand, I'm really hoping that since the whole procedure
is so simple, after a few times this has happened, people will just do the
sign-off without even thinking about it. So the "come back with a
signed-off version" case hopoefully doesn't happen too much.

So we'll have it for a while (and I'll probably add a check to my "apply"
scripts to _check_ for the sign-off thing at least for anything bigger
than a few lines), but I'm _hoping_ that in half a year people will wonder 
why we even discussed this.

And I might be wrong. Maybe it's just going to be a constant irritant, and 
we'll have to just revisit the issue and decide that it was a stupid idea. 

			Linus
