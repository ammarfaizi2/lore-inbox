Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312261AbSDOBhB>; Sun, 14 Apr 2002 21:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSDOBhA>; Sun, 14 Apr 2002 21:37:00 -0400
Received: from ns.suse.de ([213.95.15.193]:26377 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312261AbSDOBhA>;
	Sun, 14 Apr 2002 21:37:00 -0400
Date: Mon, 15 Apr 2002 03:36:59 +0200
From: Dave Jones <davej@suse.de>
To: Denis Zaitsev <zzz@cd-club.ru>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: FIXED_486_STRING ?
Message-ID: <20020415033659.E20383@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Denis Zaitsev <zzz@cd-club.ru>, Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20020413224743.A13355@natasha.zzz.zzz> <32667.1018744038@ocs3.intra.ocs.com.au> <20020414024406.A16692@suse.de> <20020415063825.A2691@natasha.zzz.zzz> <20020415030355.D20383@suse.de> <20020415072556.A2839@natasha.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 07:25:56AM +0600, Denis Zaitsev wrote:
 > On Mon, Apr 15, 2002 at 03:03:55AM +0200, Dave Jones wrote:
 > > Petko Manolov <lz5mj@yahoo.com> did some work on them circa 2.4.0test.
 > > His patch is at http://www.dce.bg/~petkan/linux/string-486.diff
 > These patches are included... 

Look again.

(davej@noodles:linux-2.4.19-pre6)$ cat ../string-486.diff | patch -p1 -F1 --dry-run
patching file include/asm-i386/string-486.h
Hunk #13 FAILED at 365.
Hunk #14 succeeded at 388 (offset -5 lines).
Hunk #15 succeeded at 409 (offset -5 lines).
Hunk #16 succeeded at 452 (offset -5 lines).
Hunk #17 succeeded at 516 (offset -5 lines).
1 out of 17 hunks FAILED -- saving rejects to file include/asm-i386/string-486.h.rej 

Almost still applies except for one hunk.
 
 > But the string-486.h itself is turned
 > off by FIXED_486_STRING.  BTW, what are the problems?

Not sure off-hand. I would hazard a guess that they copied
too little/too much, but Petko would be a better person
to ask.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
