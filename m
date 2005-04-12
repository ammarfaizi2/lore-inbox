Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVDLCKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVDLCKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 22:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVDLCKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 22:10:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:30106 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261999AbVDLCKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 22:10:39 -0400
Subject: Re: 2.6.12-rc2-mm3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <87wtr8rdvu.fsf@blackdown.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
	 <87wtr8rdvu.fsf@blackdown.de>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 12:09:22 +1000
Message-Id: <1113271762.5388.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 03:18 +0200, Juergen Kreileder wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> 
> I'm getting frequent lockups on my PowerMac G5 with rc2-mm3.
> 
> 2.6.11-mm4 works fine but all 2.6.12 versions I've tried (all since
> -rc1-mm3) lock up randomly.  The easiest way to reproduce the problem
> seems to be running Azareus.  So it might be network related, but I'm
> not 100% sure about that, there was a least one deadlock with
> virtually no network usage.
> 
> BTW, what's the SysRq key on recent Apple USB keyboards?  Alt/Cmd-F13
> doesn't work for me.

No idea about sysrq, i don't use it. However, I haven't experienced any
such problem with the various G5s we have here (and no other G5 user
reported such a problem).

So it would be useful if you could provide a bit more informations here
though. For example, what exact G5 model is this, do you have any 3rd
party PCI card, what video card are you using, can you reproduce the
crash in console mode, that sort of thing ...

Also, did you run a memtest equivalent on the machine ?

Finally, it would be useful if you could point out which specific patch
or bk snapshot, or at least -mm rev. introduced the bug. As I said
previously, you are the only one to report that and none of the G5s here
is showing such a problem.

Ben.


