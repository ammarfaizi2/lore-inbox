Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVENKRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVENKRb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 06:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVENKRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 06:17:30 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:54659 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262355AbVENKRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 06:17:08 -0400
Date: Sat, 14 May 2005 12:17:07 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mhw@wittsend.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sync option destroys flash!
Message-ID: <20050514101707.GB7963@wohnheim.fh-wedel.de>
References: <1116001207.5239.38.camel@localhost.localdomain> <1116009619.9371.494.camel@localhost.localdomain> <1116011430.5239.108.camel@localhost.localdomain> <1116021632.20550.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1116021632.20550.11.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005 23:00:34 +0100, Alan Cox wrote:
> 
> Or it may even be cheaper to "burn" a few - buy one of each type from
> various shops, do 2 million writes to the same sector and take them back
> the next day if they died [And publish the review data 8))]

Or just accept the fact that flashes are a tad different from spinning
rust.  Expecting a decent wear levelling on the cheap USB sticks and
other forms of flash is plain unrealistic.

USB stick are a bit better than old 3.5" floppies were - if both are
used with fat, minix, ext, etc.  At least they don't die by lying in a
dark drawer.  But if you want them to last, your best bet is currently
to use JFFS2 on them.

Of course, JFFS2 sucks performance-wise, so the end result currently
is that USB sticks suck in some way, no matter what you try.

Jörn

-- 
Fools ignore complexity.  Pragmatists suffer it.
Some can avoid it.  Geniuses remove it.
-- Perlis's Programming Proverb #58, SIGPLAN Notices, Sept.  1982
