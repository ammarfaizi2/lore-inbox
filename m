Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315335AbSEQC0F>; Thu, 16 May 2002 22:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSEQC0E>; Thu, 16 May 2002 22:26:04 -0400
Received: from ns.suse.de ([213.95.15.193]:24587 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315335AbSEQC0D>;
	Thu, 16 May 2002 22:26:03 -0400
Date: Fri, 17 May 2002 04:26:02 +0200
From: Dave Jones <davej@suse.de>
To: jeff millar <wa1hco@adelphia.net>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Message-ID: <20020517042602.C2009@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	jeff millar <wa1hco@adelphia.net>, Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3038.1021588938@ocs3.intra.ocs.com.au> <001901c1fd45$43be4bc0$6501a8c0@mrrmnh.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 09:50:46PM -0400, jeff millar wrote:
 > will any of the other kernels (dj, ml, ???) incorporate your system?
 > I'm about ready to try something else.

I've thought it over a few times over the last few weeks, and tbh
inclusion in any tree other than Linus' doesn't really make much sense
other than perhaps to get some more 'early adopter' testers.

The current kbuild2.5 patches will apply cleanly against my tree, but
due to things like the new input layer still not being completely merged
in Linus' tree, some files are in different places, so the Makefile.in's
in kbuild2.5 point to the wrong places.

Sure, I could merge it, but tbh it's not worth the effort right now
of fixing up those files until Linus actually says yay or nay.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
