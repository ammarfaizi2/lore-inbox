Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261477AbSKBWul>; Sat, 2 Nov 2002 17:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261481AbSKBWul>; Sat, 2 Nov 2002 17:50:41 -0500
Received: from quechua.inka.de ([193.197.184.2]:42941 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S261477AbSKBWuk>;
	Sat, 2 Nov 2002 17:50:40 -0500
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <87znssytu7.fsf@goat.bogus.local>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E1887CZ-00026A-00@sites.inka.de>
Date: Sat, 2 Nov 2002 23:57:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <87znssytu7.fsf@goat.bogus.local> you wrote:
> I still don't get it. How is this different from suid root. The worst
> I can imagine is an admin doing chcap all+eip, which is no different
> from doing a chown root; chmod u+s.

The probvlem is that most software does not know abaout capabilities. A
simple example is libc which will not ignore LD_PRELOAD because it does not
notice that there is a difference in effective and real capabilities of the
proces.

Personally I think this is solvable, and we realy need a way to enable
admins to use the least priveledge principle on their servers by removing
suid root programs completely.

Greetings
Bernd
-- 
www.freefire.org
