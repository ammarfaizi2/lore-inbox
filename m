Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUHIPj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUHIPj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUHIPg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:36:27 -0400
Received: from pcp701187pcs.bowie01.md.comcast.net ([68.50.80.175]:58756 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S266303AbUHIPfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:35:42 -0400
Subject: Re: Status with pmdisk/swsusp merge ?
From: Disconnect <swsusp@gotontheinter.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040808182234.GA620@elf.ucw.cz>
References: <1091679494.5225.186.camel@gaston>
	 <Pine.LNX.4.50.0408051517141.6736-100000@monsoon.he.net>
	 <20040808182234.GA620@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092065741.4088.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 11:35:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-08 at 14:22, Pavel Machek wrote:
> > I intend to try and merge my tree with Linus once he releases 2.6.8,
> > modulo any bugs that crop up between now and then. Feel free to send me
> > the patches to fix up ppc before then, and I will merge them as well.
> 
> Sounds good.
> 
> > As far as the device power management stuff goes, I'm wading through the
> > discussion right now..
> 
> Hopefully we can at least switch to enums so that we clear any
> confusion....
> 								Pavel

..And once thats done and the tree settles a bit I'll start working on
the swsusp2 x86_64 port again. (Unless someone who understands that
whole thing better wants to jump forward.)

FWIW I ported the 'old' pmdisk suspend code into swsusp2 and I can
suspend, but I can't resume. I haven't got a serial port (its a "modern"
laptop.. with parallel, etc but no serial..) so I'm also looking at
netconsole, digging around for a line printer, etc..

-- 
Disconnect <swsusp@gotontheinter.net>

