Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290891AbSBFXGb>; Wed, 6 Feb 2002 18:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290866AbSBFXGL>; Wed, 6 Feb 2002 18:06:11 -0500
Received: from bitmover.com ([192.132.92.2]:40137 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290853AbSBFXGC>;
	Wed, 6 Feb 2002 18:06:02 -0500
Date: Wed, 6 Feb 2002 15:06:02 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020206150602.W7674@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@suse.cz>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.31.0202051928330.2375-100000@cesium.transmeta.com> <20020206193818.GA158@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020206193818.GA158@elf.ucw.cz>; from pavel@suse.cz on Wed, Feb 06, 2002 at 08:38:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 08:38:18PM +0100, Pavel Machek wrote:
> Hey, this looks very good! At this level of verbosity, it might be
> nice to also list modified files, but this is really good.

He generated that listing with "bk changes", you want "bk changes -v", which
I included below, but doesn't have any more useful info (yet) because the
comments are all auto generated from the email.  

We will stick up a web page someplace that says "send Linus comments
like this if you want individual file comments to be different", and is
totally BK agnostic, i.e., you can send them with a regular diff -Nur
style patch and the import tools will do the right thing.  Then the
verbose listing will start to be useful.

--lm

ChangeSet
  1.237 02/02/06 10:57:18 reiser@namesys.com +1 -0
  [PATCH] reiserfs fix for inodes with wrong item versions (2.5)
  
     This is hopefully last bugfix for a bug introduced by struct inode splittin
g.
     Because of setting i_flags to some value and then cleaning the i_flags
     contents later, on-disk items received wrong item version ob v3.6 filesyste
ms

  fs/reiserfs/inode.c
    1.34 02/02/06 10:57:17 reiser@namesys.com +7 -7
    reiserfs fix for inodes with wrong item versions (2.5)
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
