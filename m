Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTIAIMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 04:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbTIAIMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 04:12:12 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:22928 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261946AbTIAIMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 04:12:09 -0400
Date: Mon, 1 Sep 2003 10:11:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901081154.GB155@elf.ucw.cz>
References: <20030831232812.GA129@elf.ucw.cz> <20030901075726.A12457@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901075726.A12457@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Please take attached patch, and apply with -R, to bring tree back to
> > -test3 state. It should be a non-brainer, as Patrick's patch should
> > not go in in the first place. [If you can do some bk magic to exclude
> > Patrick's power managment merge, that would be even better].
> 
> Please don't.  A number of us are working _with_ Patrick to sort the
> problems out and get them resolved.  IMHO, there are good changes in
> Pat's work, and backing the lot out would be silly at this point.

Its the only way to have power managment working by 2.6.1. Lots of
work went into pm during 2.5 series, and Patrick invalidated all that
with one, 140KB, untested and broken patch (and he managed to break
about all rules about patch submission). It is not possible to fix
damage he done within week.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
