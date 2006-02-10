Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWBJTRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWBJTRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWBJTRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:17:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750957AbWBJTRT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:17:19 -0500
Date: Fri, 10 Feb 2006 11:16:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: fix mistake in documentation
Message-Id: <20060210111614.5ff4030d.akpm@osdl.org>
In-Reply-To: <20060210122923.GM3389@elf.ucw.cz>
References: <200602101314.44571.rjw@sisk.pl>
	<20060210122923.GM3389@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> On Pá 10-02-06 13:14:44, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > This patch fixes a mistake in the swsusp documentation.
> > 
> > Please apply.
> > 
> > Greetings,
> > Rafael
> 
> BTW, I believe that Andrew hates these Hi, Please apply and greatings
> in patches; because he has to manually strip them down. There's some
> '---' convention to work around them, but it is probably easier to
> just be "rude" with him and only pass changelog in the mail. Not sure
> what to do with diffstat. 

diffstats are nice.  Yes, please put them after the ^---

wrt changelogs: yes, I do edit away all the fluff, but it doesn't take long.

This is totally anal, but my pet peeve is changelogs which start with "This
patch frobs the nozzle to ..".  I often change that to "Frob the nozzle
to...", because the "This patch ...." stuff is wholly redundant once the
thing hits the git tree.

What's remarkable is how many English sentences still make sense if you
blindly convert "This patch <word>s ..." into "<Word> ...".  It's
practically automatable.

<we shall now resume normal programming>

> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ACK, if it is worth anything.
> 
> I got these in mail today:
> 
> 18   T 10-02-06 akpm@osdl.org        ( 144) - swsusp-low-level-interface-rev-2-fix.patch removed fro  
> 19   T 10-02-06 akpm@osdl.org        ( 107) - suspend-to-ram-allow-video-options-to-be-set-at-runtim  
> 20   T 10-02-06 akpm@osdl.org        (  84) - swsusp-userland-interface-update.patch removed from -m  
> 21   T 10-02-06 akpm@osdl.org        ( 101) - suspend-update-documentation.patch removed from -mm tr  
> 22   T 10-02-06 akpm@osdl.org        ( 108) - led-add-sharp-charger-status-led-trigger-tidy.patch re
> 
> ...I quite like those patches, and I do not see them going to
> Linus. Should I just be more patient, or did they go into some
> top-secret-tree I do not know about (but not yet to Linus)?

Ah, sorry.  I had a big consolidation yesterday: folded over 50 fixup
patches into their parent patches.
