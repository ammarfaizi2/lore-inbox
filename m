Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270346AbTGMTJN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270347AbTGMTJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:09:13 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:58319 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270346AbTGMTJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:09:10 -0400
Date: Sun, 13 Jul 2003 21:23:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030713192329.GB570@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <1058021722.1687.16.camel@laptop-linux> <20030712153719.GA206@elf.ucw.cz> <1058041211.2007.1.camel@laptop-linux> <20030713132704.GC19132@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713132704.GC19132@mail.jlokier.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Okay, that's sane approach to do it... But where do you store pointer
> > > to pagedir?
> > 
> > I didn't answer this before. Sorry. Initially, you would still be
> > expected to have a suspend partition, and hence it would still go in the
> > header. Longer term, I'll have to learn more and see if there's a place
> > we can use in the partition table or such like.
> 
> You could also just make it a kernel command line option, for the
> bootloader to store.  It's not like it needs to move each time you
> suspend - if you store the first block in a file in /boot.

Okay, so we would simply require bootloader to tell us
"resume=/dev/hda@LBA=1234"? I guess that's quite clean, altrough it
needs bootloader change. Queue that for 2.7.0 ;-).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
