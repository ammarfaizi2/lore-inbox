Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312556AbSDOBD6>; Sun, 14 Apr 2002 21:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSDOBD5>; Sun, 14 Apr 2002 21:03:57 -0400
Received: from ns.suse.de ([213.95.15.193]:7688 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312556AbSDOBD5>;
	Sun, 14 Apr 2002 21:03:57 -0400
Date: Mon, 15 Apr 2002 03:03:55 +0200
From: Dave Jones <davej@suse.de>
To: Denis Zaitsev <zzz@cd-club.ru>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: FIXED_486_STRING ?
Message-ID: <20020415030355.D20383@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Denis Zaitsev <zzz@cd-club.ru>, Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20020413224743.A13355@natasha.zzz.zzz> <32667.1018744038@ocs3.intra.ocs.com.au> <20020414024406.A16692@suse.de> <20020415063825.A2691@natasha.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 06:38:26AM +0600, Denis Zaitsev wrote:
 > Yes, the special code for Pentium is important for it, as that code is
 > faster and shorter.  The last signature in string-486.h is of
 > 2000/05/09, so, if this is true, the problems have not been fixed.
 > So, what is the real situation?  I would like to fix the code, and it
 > seems that I'm not alone :)

Petko Manolov <lz5mj@yahoo.com> did some work on them circa 2.4.0test.
His patch is at http://www.dce.bg/~petkan/linux/string-486.diff
Aparently there are still 1-2 problems with these routines which is
why he hasn't pushed for inclusion I guess.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
