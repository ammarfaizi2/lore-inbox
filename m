Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTDNRJf (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTDNRJf (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:09:35 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:28900 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263566AbTDNRJe (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:09:34 -0400
Date: Mon, 14 Apr 2003 19:21:11 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: James Bourne <jbourne@hardrock.org>
Cc: Martin Schlemmer <azarah@gentoo.org>,
       Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy
Message-ID: <20030414172111.GI10347@wohnheim.fh-wedel.de>
References: <20030414144709.GE10347@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0304141048390.24506-100000@cafe.hardrock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0304141048390.24506-100000@cafe.hardrock.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 April 2003 11:09:02 -0600, James Bourne wrote:
> 
> If you only change the one line and add the new variable I'm afraid it won't
> work due to other things changing as well...  At least the files 
> Makefile
> Rules.make
> arch/ppc/boot/Makefile
> arch/arm/boot/Makefile
> scripts/patch-kernel
> scripts/mkspec
> scripts/Menuconfig
> 
> will need to be looked at as these are ones which contain references to
> SUBVERSION...  References to EXTRAVERSION also reside in these files.  It
> would just be better to do the "right thing" IMHO.
> 
> I will take a look at this and produce a patch for the same.

Ok. But the patch I lost really didn't do anything else and works for
me (TM).

joern@Limerick:~$ uname -a
Linux Limerick 2.4.20.1-je1 #3 Sun Apr 6 22:20:45 CEST 2003 i686 unknown unknown GNU/Linux
joern@Limerick:~$ 


Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike
