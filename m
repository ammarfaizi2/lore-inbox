Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135733AbRD2Lg3>; Sun, 29 Apr 2001 07:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135732AbRD2LgP>; Sun, 29 Apr 2001 07:36:15 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:13316 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S135734AbRD2Lfx>;
	Sun, 29 Apr 2001 07:35:53 -0400
Date: Fri, 27 Apr 2001 10:47:24 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jes Sorensen <jes@linuxcare.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
Subject: Re: Architecture-specific include files
Message-ID: <20010427104724.B37@(none)>
In-Reply-To: <20010422210118.Z18464@parcelfarce.linux.theplanet.co.uk> <d34rvc2ztg.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <d34rvc2ztg.fsf@lxplus015.cern.ch>; from jes@linuxcare.com on Thu, Apr 26, 2001 at 03:51:39AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Matthew> Something which came up in one of the hallway discussions at
> Matthew> the kernelsummit was that a lot of the architecture
> Matthew> maintainers would find it more convenient if the
> Matthew> arch-specific header files were moved from include/asm-
> Matthew> to arch//include.  Since we use a symlink _anyway_, no
> Matthew> global changes to include statements are necessary, we'd
> Matthew> merely need to change Makefile from
> 
> [snip]
> 
> Matthew> Would anyone have a problem with this change?  It'll make for
> Matthew> a hell of a big patch from Linus, but it really will simplify
> Matthew> the lives of the architecture maintainers.
> 
> I don't see what it saves, except for the fact you just have to run
> diff -urN once instead of twice when you want to send Linus a large
> diff. Or am I missing something?

Saving one diff urN is nice, plus you can distribute your architecture
as tar file more easily, plus it is easier to put just your arch in cvs.

I like it.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

