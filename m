Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVDUTBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVDUTBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 15:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVDUTBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 15:01:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13711 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261769AbVDUTBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 15:01:02 -0400
Date: Thu, 21 Apr 2005 21:00:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Petr Baudis <pasky@ucw.cz>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421190009.GC475@openzaurus.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421162220.GD30991@pasky.ji.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > You should put this into .git/remotes
> > > 
> > > linus	rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> (git addremote is preferred for that :-)

Oops :-).

> > Well, not sure.
> > 
> > I did 
> > 
> > git track linus
> > git cancel
> > 
> > but Makefile still contains -rc2. (Is "git cancel" right way to check
> > out the tree?)
> 
> No. git cancel does what it says - cancels your local changes to the
> working tree. git track will only set that next time you pull from
> linus, the changes will be automatically merged. (Note that this will
> change with the big UI change.)

Is there way to say "forget those changes in my repository, I want
just plain vanilla" without rm -rf?
I see quite a lot of problems with fsck-tree. Is that normal?
(I ran out of disk space few times during different operations...)


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

