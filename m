Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311530AbSDNAoK>; Sat, 13 Apr 2002 20:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311536AbSDNAoJ>; Sat, 13 Apr 2002 20:44:09 -0400
Received: from ns.suse.de ([213.95.15.193]:20749 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311530AbSDNAoJ>;
	Sat, 13 Apr 2002 20:44:09 -0400
Date: Sun, 14 Apr 2002 02:44:06 +0200
From: Dave Jones <davej@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Denis Zaitsev <zzz@cd-club.ru>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: FIXED_486_STRING ?
Message-ID: <20020414024406.A16692@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Keith Owens <kaos@ocs.com.au>, Denis Zaitsev <zzz@cd-club.ru>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20020413224743.A13355@natasha.zzz.zzz> <32667.1018744038@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 10:27:18AM +1000, Keith Owens wrote:

 > Dead code, it has been dead since at least 2.0.21.  Unless somebody
 > wants to fix the string-486 code, delete FIXED_486_STRING,
 > CONFIG_X86_USE_STRING_486 and include/asm-i386/string-486.h.

I proposed doing this a few months back, then someone stepped forward
who had worked on these routines recently and fixed up whatever problems
they originally exhibited.  Deleting the dead code from 2.2 / 2.4 probably
makes sense, but it'd be nice to have the 2.5 ones fixed up.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
