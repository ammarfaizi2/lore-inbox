Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271359AbTG2Jol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271379AbTG2Jok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:44:40 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:11707 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271359AbTG2Jof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:44:35 -0400
Date: Tue, 29 Jul 2003 11:44:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: cursor started to disappear
Message-ID: <20030729094416.GB262@elf.ucw.cz>
References: <20030728181408.GA499@elf.ucw.cz> <20030728182757.GA1793@win.tue.nl> <20030728131741.528a4707.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728131741.528a4707.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Plus I'm seeing some silent data corruption. It may be
> > > swsusp or loop related
> > 
> > Loop is not stable at all. Unsuitable for daily use.
> 
> That's the first I've heard about it.  Do you have some details on this?  A
> test case perhaps?

After a while (week of use), kernel started complaining about "block
already freed in inode X" or something like that. I rebooted and fsck
found nothing serious (that is normal loop). I've now switched to
Jari's version of loop -- I'd like to keep this filesystem.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
