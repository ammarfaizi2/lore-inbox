Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTIOAQj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 20:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTIOAQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 20:16:39 -0400
Received: from mail.hometree.net ([212.34.184.41]:64661 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S262375AbTIOAQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 20:16:37 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Date: Mon, 15 Sep 2003 00:16:35 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bk30d3$ftu$1@tangens.hometree.net>
References: <20030914043716.GA19223@codepoet.org> <Pine.LNX.4.10.10309132152510.16744-100000@master.linux-ide.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1063584995 16318 212.34.184.4 (15 Sep 2003 00:16:35 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 15 Sep 2003 00:16:35 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> writes:


>It is coming and the intent is to return all the stolen symbols.
>It is free for anyone to use and enjoy the usage of Linux once again.
>So everyone get in line and SUE ME for GPL'ed drivers.

[... module code that would re-export GPL-marked symbols as non-GPL-marked snipped ...]

Well,

generally speaking, you're of course right. You're simply using the
loophole of Linus' agreement to binary only modules to use a fully
GPL'ed module (which might use the _GPL symbols), then consider the
aggregation to be under GPL (IMHO correct) and then consider this
aggregation of kernel and your module to be still covered by Linus'
agreement (don't know whether this is true. You might want to actually
ask Linus himself... ;-) )

IMHO doing so might be the best way to make Linus (as the main
copyright holder on the kernel source) to simply revoke the "I won't
object to loading binary only modules in the GPL'ed kernel" agreement
and simply say "From Kernel 2.6 on, every aggregation of modules in
kernel space is considered to be an aggregation in the GPL v2 sense of
meaning as covered by the GPL v2. So if you want to load a module,
it's code is better be GPL'ed too".

In other words: You might force the copyright holder(s) of the Linux
kernel to kill your business model dead.

Is this really what you want? It's basically the same thing that
people do with BitKeeper and Mr. McVoy: Annoy the people that you
might depend on long enough and they might stop being friendly to you
[1]. You might want to ask yourself if this _really_ is what you want
to achieve.

	... just my random 0,02 Euro-Cent
		Henning

[1] The people opposing to BK might not use it themselves but they n
might be heavily using a project which might not be able to go on
without BK because the main developers have stated often enough, that
they won't be able to cope with the work load without BK: The Linux
kernel.
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)
