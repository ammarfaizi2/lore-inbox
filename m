Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSLOPxH>; Sun, 15 Dec 2002 10:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbSLOPxH>; Sun, 15 Dec 2002 10:53:07 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3076 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262089AbSLOPwq>;
	Sun, 15 Dec 2002 10:52:46 -0500
Date: Mon, 9 Dec 2002 08:29:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Eric Altendorf <EricAltendorf@orst.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Jochen Hein <jochen@jochen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50, ACPI] link error
Message-ID: <20021209072911.GA2934@zaurus>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212031247.07284.EricAltendorf@orst.edu> <20021205173145.GB731@elf.ucw.cz> <200212062150.06350.EricAltendorf@orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212062150.06350.EricAltendorf@orst.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Right ... I'm no kernel hacker so I don't know why, but I can
> > > only get the recent kernels to compile with sleep states if I
> > > turn *ON* software suspend as well.  However, as soon as I turn
> > > on swsusp and get a compiled kernel, it oops'es on boot.
> >
> > Can you mail me decoded oops?
> > 								Pavel
> 
> This is the first time I've decoded an oops, and since I had to decode it on a different kernel (2.5.25) than the one I'm debugging (2.5.50 + Dec 6 ACPI patch), and I couldn't 
Can you try passing 
"resume=hda5_or_whatever_your_swap_partition_is"?


-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

