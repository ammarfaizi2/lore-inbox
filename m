Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTFIA6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 20:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbTFIA6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 20:58:24 -0400
Received: from codepoet.org ([166.70.99.138]:39382 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264134AbTFIA6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 20:58:13 -0400
Date: Sun, 8 Jun 2003 19:11:53 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Paul Jakma <paul@clubi.ie>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linksys WRT54G and the GPL
Message-ID: <20030609011153.GA11362@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Paul Jakma <paul@clubi.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030608233546.GA11064@codepoet.org> <Pine.LNX.4.44.0306090105320.15572-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306090105320.15572-100000@fogarty.jakma.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jun 09, 2003 at 01:09:45AM +0100, Paul Jakma wrote:
> On Sun, 8 Jun 2003, Erik Andersen wrote:
> 
> > BTW, this is what I did to open up the Linksys rom...
> 
> interesting.. what do you make of:
> 
> 	http://download.qlogic.com/sf/10215/fullimage_1.5.1.04.zip
> 
> which is the firmware that runs on QLogic SANBox2 2Gbit fibre-channel
> switches (Cyrix MediaGX iirc). Looking at strings it includes
> software such as glib (LGPL), Linux and GRUB.
> 
> QLogic did not answer my request for source to the (L)GPL 
> parts of the firmware when i asked them.

gzip magic at 0x4110 for a compressed 1.7 MB, i386, 
2.4.18-xfs linux kernel

x86 boot sector with GRUB at 0xE3ACB6

gzip magic at 0xFA0E4 for file named "image" that contains 
a compressed 24 MB ext2 filesystem

gzip magic at 0x80D278 for a compressed 1.7 MB, i386,
2.4.18-xfs linux kernel (apparently a backup)

gzip magic at 0x90324Ci for a file name "fl_image" that
also contains a compressed 24 MB ext2 filesystem

A quick look through their filesystem shows plenty of GPL'd
stuff.  Mostly looks lika RedHat ripoff, with a bunch of
apparently proprietary junk under /itasca,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
