Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312455AbSDSNAv>; Fri, 19 Apr 2002 09:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSDSNAv>; Fri, 19 Apr 2002 09:00:51 -0400
Received: from ns.suse.de ([213.95.15.193]:51465 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312455AbSDSNAu>;
	Fri, 19 Apr 2002 09:00:50 -0400
Date: Fri, 19 Apr 2002 15:00:48 +0200
From: Dave Jones <davej@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.9 patch] Fix bluesmoke/mce compiler warnings.
Message-ID: <20020419150048.E15517@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Anton Altaparmakov <aia21@cantab.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16yVSw-0001Iv-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 11:18:05AM +0100, Anton Altaparmakov wrote:
 > Please consider below patch for inclusion. It fixes compiler warnings
 > from arch/i386/kernel/bluesmoke.c which appear due to smp_call_function
 > expecting a function pointer taking an argument to a void * but
 > mce_checkregs takes an int argument...

Robert Love's patch to fix these up did it with less unnecessary casts,
and seems to be ok in my testing.
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/*checkout*/linux-dj/linux-2.5/arch/i386/kernel/bluesmoke.c

(This contains some other bits too that I intend to push to Linus after
 a pre1 appears)

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
