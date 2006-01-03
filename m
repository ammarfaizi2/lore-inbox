Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWACTYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWACTYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWACTYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:24:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:27919 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751476AbWACTYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:24:43 -0500
Date: Tue, 3 Jan 2006 20:24:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/26] gitignore: x86_64 files
Message-ID: <20060103192427.GA20336@mars.ravnborg.org>
References: <20060103132035.GA17485@mars.ravnborg.org> <p73wthhi7v9.fsf@verdi.suse.de> <20060103171517.GB20001@mars.ravnborg.org> <200601031826.42028.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601031826.42028.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 06:26:41PM +0100, Andi Kleen wrote:
 
> > Today there are 23 .gitignores in the kernel - including the ones
> > from this patchset.
> 
> And next year .cvsignores and .svnignores and .hgignores and 
> .whateveriscurrentlyenvoguesvmignores ?

The kernel will contain files relevant for the main SCM used for kernel
development. If people prefer bk, cvs, hg or whatever they will most
likely have similar info in a branch that never hits mainline.

Not maintaining a set of .gitignore files for x86_64 will hit all
users of git for x86_64.
Having a file in arch/ containing a list of generated files for each and
every arch does confilt with the distributed nature of how SW is
developed for the kernel.

The files are hidden for all normal cases so they should not
hurt - or?

Added Linus to this thread - he was the one that wrote this in top-level
.gitignore:

# NOTE! Don't add files that are generated in specific
# subdirectories here. Add them in the ".gitignore" file
# in that subdirectory instead.

	Sam
