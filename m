Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWBFT1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWBFT1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWBFT1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:27:35 -0500
Received: from cantor2.suse.de ([195.135.220.15]:34231 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932302AbWBFT1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:27:34 -0500
Date: Mon, 6 Feb 2006 20:27:21 +0100
From: Olaf Hering <olh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Christoph Hellwig <hch@infradead.org>,
       Jeff Mahoney <jeffm@suse.com>, LKML <linux-kernel@vger.kernel.org>,
       kernel-bugzilla@luksan.cjb.net
Subject: Re: quality control
Message-ID: <20060206192721.GA8600@suse.de>
References: <43E64791.8010302@namesys.com> <43E6521F.5020707@suse.com> <43E6BF48.5010301@namesys.com> <BAFD888C-7E6B-49B1-A394-901D24CFBCBF@mac.com> <p73hd7clp5k.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <p73hd7clp5k.fsf@verdi.suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Feb 06, Andi Kleen wrote:

> Kyle Moffett <mrmacman_g4@mac.com> writes:
> > 
> > It's a GIT version of an RC patch for grief's sake!  You don't
> > seriously expect people to quadruple-check every trivial patch that
> > goes into Linus GIT tree before sending it, do you? 
> 
> No quadruple check, but every patch going to Linus should get at least
> some basic testing and it's definitely suppose to compile at least
> in one .config combination.

Right. We have now git-bisect, and it helped me to nail down a few bugs.
Just now I track down some scsi or whatever breakage in -rc1. And guess
what, not a single compile error so far, with a full featured config!
So you guys better send tested patches, via akpm, to keep Linus tree in
a reasonable shape.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
