Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVDUL1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVDUL1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVDULYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:24:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46001 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261305AbVDULVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:21:13 -0400
Date: Thu, 21 Apr 2005 13:20:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, pasky@ucw.cz
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421112022.GB2160@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> And for the crazy people, the git archive on kernel.org is up and running 
> under /pub/scm/linux/kernel/git/torvalds/linux-2.6.git. For the 
> adventurous of you, the name of the 2.6.12-rc3 release is a very nice and 
> readable:
> 
> 	a2755a80f40e5794ddc20e00f781af9d6320fafb
> 
> and eventually I'll try to make sure that I actually accompany all 
> releases with the SHA1 git name of the release signed with a digital 
> signature. 

As far as I can see... (working with pasky's version of git....)

You should put this into .git/remotes

linus	rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Then

RSYNC_FLAGS=-zavP git pull linus

should do the right thing.

[pasky, would it be possible to make some kind of progress indication
default for long pulls?]

> One of the tools I don't have set up yet is the old "shortlog" script, so 
> I did this really hacky conversion. You don't want to know, but let's say 
> that I'm re-aquainting myself with 'sed' after a long time ;). But if some 
> lines look like they got hacked up in the middle, rest assured that that's 
> exactly what happened, and the long log should have the rest ...

-- 
Boycott Kodak -- for their patent abuse against Java.
