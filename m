Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269138AbTCBH7A>; Sun, 2 Mar 2003 02:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269139AbTCBH7A>; Sun, 2 Mar 2003 02:59:00 -0500
Received: from pdbn-d9bb8750.pool.mediaWays.net ([217.187.135.80]:26128 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S269138AbTCBH67>;
	Sun, 2 Mar 2003 02:58:59 -0500
Date: Sun, 2 Mar 2003 09:09:10 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Dan Kegel <dank@kegel.com>
Cc: Steven Cole <elenstev@mesatop.com>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
Message-ID: <20030302080910.GA2124@citd.de>
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de> <3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com> <3E6167B1.6040206@kegel.com> <3E617428.3090207@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E617428.3090207@kegel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 07:02:00PM -0800, Dan Kegel wrote:
> My corrections file is up at http://www.kegel.com/spell-fix-dan1.txt
> and the patch that produces is
> http://www.kegel.com/linux-2.5.63-bk5-spell.patch.bz2.bin
> The perl script took about an hour of 450MHz cpu time.
> (Might be worth adding a quick path to detect and skip
> files with none of the misspelled words.  Or just run
> on a fast machine...)

OK. Next Take.

Changes this time:
- A bug-fix for "--dir" (Would have checked all files)
- Added a "fast-path" but this doesn't seem to make a difference

New options:
- "--[no]fix" to fix (default) or only look for errors.
  (This ignores the '[no]comment'-option and looks for all errors!)
- "--[no]override" to override(default) the original file or create a
  "<filename>.fixed"-file


Anyone wants a "--[no]ask"-option?




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

