Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270352AbTGMTOw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270351AbTGMTOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:14:51 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45972 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270352AbTGMTOu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:14:50 -0400
Date: Sun, 13 Jul 2003 20:29:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030713192919.GD20573@mail.jlokier.co.uk>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <1058021722.1687.16.camel@laptop-linux> <20030712153719.GA206@elf.ucw.cz> <1058041211.2007.1.camel@laptop-linux> <20030713132704.GC19132@mail.jlokier.co.uk> <20030713192329.GB570@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713192329.GB570@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > You could also just make it a kernel command line option, for the
> > bootloader to store.  It's not like it needs to move each time you
> > suspend - if you store the first block in a file in /boot.
> 
> Okay, so we would simply require bootloader to tell us
> "resume=/dev/hda@LBA=1234"? I guess that's quite clean, altrough it
> needs bootloader change. Queue that for 2.7.0 ;-).

Actually it doesn't require a bootloader change, though that would be
easiest for users :)

-- Jamie
