Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbTGMNMj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 09:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbTGMNMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 09:12:38 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:28820 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265922AbTGMNMi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 09:12:38 -0400
Date: Sun, 13 Jul 2003 14:27:04 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@suse.cz>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030713132704.GC19132@mail.jlokier.co.uk>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <1058021722.1687.16.camel@laptop-linux> <20030712153719.GA206@elf.ucw.cz> <1058041211.2007.1.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058041211.2007.1.camel@laptop-linux>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> On Sun, 2003-07-13 at 03:37, Pavel Machek wrote:
> > Okay, that's sane approach to do it... But where do you store pointer
> > to pagedir?
> 
> I didn't answer this before. Sorry. Initially, you would still be
> expected to have a suspend partition, and hence it would still go in the
> header. Longer term, I'll have to learn more and see if there's a place
> we can use in the partition table or such like.

You could also just make it a kernel command line option, for the
bootloader to store.  It's not like it needs to move each time you
suspend - if you store the first block in a file in /boot.

-- Jamie
