Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbUBPUsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUBPUsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:48:23 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:19338 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265859AbUBPUsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:48:05 -0500
Date: Mon, 16 Feb 2004 22:03:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: oddment in build vs reported version
Message-ID: <20040216210340.GE2977@mars.ravnborg.org>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <200401302306.01366.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401302306.01366.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 11:06:01PM -0500, Gene Heskett wrote:
> I use a script to build new kernels, and this script controls the 
> vmlinuz-version-number-s of the bzImage file copied to /boot when its 
> done with the build.  This scripts sets the vmlinuz-x.x.x filename 
> correctly:
> 
> VER=2.6.2-rc2-mm2
> and
> cp -f arch/i386/boot/bzImage /boot/vmlinuz-$VER && \
> 
> So the vmlinuz is correctly named.
> 
> The version number in the makefile is correct:
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 2
> EXTRAVERSION =-rc2-mm2
> 
> But when the build is all done and rebooted to, uname -a spits this 
> out:
> Linux coyote.coyote.den 2.6.2-rc2-mm1 #2 Fri Jan 30 11:04:30 EST 2004 
> i686 athlon i386 GNU/Linux
> 
> WTF?
Please triple check that you copied the right vmlinuz.
noone else reported this problem.
Also make sute your grup/lilo points at the right kernel.

	Sam
