Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWIXQex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWIXQex (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWIXQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:34:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39075 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751205AbWIXQev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:34:51 -0400
Date: Sun, 24 Sep 2006 09:34:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Petr Baudis <pasky@suse.cz>, David Schwartz <davids@webmaster.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: The GPL: No shelter for the Linux kernel?
In-Reply-To: <Pine.LNX.4.61.0609240952240.28459@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0609240923331.4388@g5.osdl.org>
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com>
 <Pine.LNX.4.61.0609231004330.9543@yvahk01.tjqt.qr> <Pine.LNX.4.64.0609231051570.4388@g5.osdl.org>
 <20060923181406.GC11916@pasky.or.cz> <Pine.LNX.4.61.0609240952240.28459@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Sep 2006, Jan Engelhardt wrote:
> 
> Would every file that does not contain an explicit license (this 
> excludes MODULE_LICENSE) falls under COPYING?

Basically, yes. There's nothing to really say that you need to state your 
copyright license in every individual file, especially if those files are 
only ever distributed as a whole, together with other things (which souce 
code obviously is - you generally cannot even use an individual *.c file 
without the infrastructure it was written for).

If a file doesn't have a license mentioned, it doesn't mean that it's 
"free for all" or not copyrighted, it just means that you need to find out 
what the license is some other way (and if you can't find out, you 
shouldn't be copying that file ;)

Of course, for clarity, a lot of projects end up adding at least a minimal 
copyright header license everywhere, just to cover their *sses. It's not 
required, but maybe it avoids some confusion, especially if that file is 
later copied into some other project with other basic rules (but if you 
do that, you really _should_ have added the information at that point!).

Me personally, I prefer to not see huge boiler-plate licenses at the top 
of the file, so that every time I open a new file I just see the dang 
license that has nothing to do with why I'm opening it. So I tend to do a 
fairly minimal thing ("Copyright (C) Linus Torvalds 2006" or similar) but 
sometimes I drop even that (ie I personally feel silly adding a copyright 
message to a header file, so I usually don't - and sometimes I just 
forget about it in real source files too)..

Others are more anal^H^H^H^Hcareful, and tend to add a few lines to tell 
what the license is, the ubiqutous "all rights reserved" (which is just 
idiocy), and a blinking gif advertisement for their company. Oh, and the 
"no warranty" clause. And an aphorism or two.

In other words, I don't think there are any real rules. Different people 
and different projects have more or less different rules. If you expect to 
collect treble damages in the US, you might want to add a copyright notice 
just about everywhere, "just in case", and to "show you really care".

IANAL, of course.

			Linus
