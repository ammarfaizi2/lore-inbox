Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVDUMDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVDUMDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 08:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVDUMDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 08:03:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64720 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261318AbVDUMDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 08:03:46 -0400
Date: Thu, 21 Apr 2005 14:03:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, pasky@ucw.cz
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421120327.GA13834@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421112022.GB2160@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > And for the crazy people, the git archive on kernel.org is up and running 
> > under /pub/scm/linux/kernel/git/torvalds/linux-2.6.git. For the 
> > adventurous of you, the name of the 2.6.12-rc3 release is a very nice and 
> > readable:
> > 
> > 	a2755a80f40e5794ddc20e00f781af9d6320fafb
> > 
> > and eventually I'll try to make sure that I actually accompany all 
> > releases with the SHA1 git name of the release signed with a digital 
> > signature. 
> 
> As far as I can see... (working with pasky's version of git....)
> 
> You should put this into .git/remotes
> 
> linus	rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> Then
> 
> RSYNC_FLAGS=-zavP git pull linus
> 
> should do the right thing.

Well, not sure.

I did 

git track linus
git cancel

but Makefile still contains -rc2. (Is "git cancel" right way to check
out the tree?)

and git diff -r linus: still contains some changes. [I did some
experimental pull of scsi changes long time ago, is it that problem?]

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
