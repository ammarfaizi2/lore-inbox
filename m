Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933420AbWKSWE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933420AbWKSWE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 17:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933426AbWKSWEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 17:04:25 -0500
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:50827 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S933420AbWKSWEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 17:04:25 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] PM: suspend/resume debugging should depend on  SOFTWARE_SUSPEND
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	<Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 19 Nov 2006 23:04:23 +0100
In-Reply-To: <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
Message-ID: <m3ac2nt7o8.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I never use SOFTWARE_SUSPEND, and I think the whole concept is totally 
> broken.
> 
> Sane people use suspend-to-ram, and that's when you need the suspend and 
> resume debugging.
> 
> Software-suspend is silly. I want my machine back in three seconds, not 
> waiting for minutes..

Suspend-to-disk has a few advantages over suspend-to-ram: 

With suspend-to-disk I can remove the battery (to put in a fresh
battery when traveling), try doing that with suspend-to-ram.  It's
also really useful for my moving my old Thinkpad which has a battery
which is so bad it can't even hold power for suspend-for-ram for more
than a few seconds.

With suspend-to-disk I can suspend Linux, resume Windows to be able to
run that one program I have to run under Windows, suspend Windows and
resume Linux again without having to restart alla applications.

And yes, this have been very useful for me in real life.  So it's
really nice to have both suspend-to-disk and suspend-to-ram.

  /Christer


-- 
"Just how much can I get away with and still go to heaven?"

Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
