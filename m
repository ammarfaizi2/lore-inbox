Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265570AbTIJTcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbTIJT34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:29:56 -0400
Received: from gprs145-173.eurotel.cz ([160.218.145.173]:3459 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265677AbTIJT3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:29:00 -0400
Date: Wed, 10 Sep 2003 21:28:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tom Winkler <tom@qwws.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BugReport: USB (ACPI), E100, SWSUSP problems (test5 vs. test3)
Message-ID: <20030910192840.GF2589@elf.ucw.cz>
References: <200309101511.26593.tom@qwws.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309101511.26593.tom@qwws.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - SWSUSP
>   In test5 there is no /proc/acpi/sleep
>   In test3 suspend to disk (and resume) works in "console only" mode. 
> Suspending from X11 works too but resuming hangs. The last message that gets 
> displayed is "Waiting for DMAs to settle down...". At this point the machine 
> seems to freeze completely.
> Remark: I had SWSUSP working on this very same machine with older 2.4 kernels 
> and seperat SWSUSP patches. It never worked with 2.6 so far.

Test again in -test6 or -test7. Big changes are now going on.

Or take -test3 and try to find out which hardware driver needs to be
unloaded in order for swsusp to work.

									Pavel


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
