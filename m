Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbTAJVjo>; Fri, 10 Jan 2003 16:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbTAJVjo>; Fri, 10 Jan 2003 16:39:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266435AbTAJVjm>;
	Fri, 10 Jan 2003 16:39:42 -0500
Date: Fri, 10 Jan 2003 21:48:27 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030110214827.Z26554@parcelfarce.linux.theplanet.co.uk>
References: <20030110144325.T26554@parcelfarce.linux.theplanet.co.uk> <20030110.130023.08256524.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030110.130023.08256524.davem@redhat.com>; from davem@redhat.com on Fri, Jan 10, 2003 at 01:00:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> Note that other architectures have never been an issue for releasing new
> kernels, and that is _particularly_ true of architectures like parisc and
> mips that haven't even _tried_ to track development kernels. In fact, mips
> "anti-maintenance" has often actively discouraged people from even
> bothering to update mips code when adding new features.

Um.. hey!  Just because we weren't trying to merge with you during 2.5
for a long time doesn't mean we weren't tracking development.  Looking
at our CVS history, we've merged your tree into ours in:

 2.5.26
 2.5.32
 2.5.41
 2.5.43
 2.5.44
 2.5.45
 2.5.46
 2.5.47
 2.5.50
 2.5.51
 2.5.53
 2.5.54

Our outstanding diff vs your tree is about 200k gzipped and it's almost
all drivers.  Off the top of my head, I can't think of any core changes
we still need.  I don't think we're using any deprecated interfaces
(eg flush_page_to_ram, unlike m68k, mips, mips64, sparc32 & v850).

Of course, I don't consider having working PA-RISC in your tree to be
a prerequisite for release.  I just object to being used as an example :-P

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
