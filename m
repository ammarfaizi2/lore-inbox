Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278687AbRJXSHZ>; Wed, 24 Oct 2001 14:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRJXSHQ>; Wed, 24 Oct 2001 14:07:16 -0400
Received: from ns.suse.de ([213.95.15.193]:14351 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278687AbRJXSHI>;
	Wed, 24 Oct 2001 14:07:08 -0400
Date: Wed, 24 Oct 2001 20:07:42 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Sven Vermeulen <sven.vermeulen@rug.ac.be>
Cc: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13: some compilerwarnings...
In-Reply-To: <20011024195342.A464@Zenith.starcenter>
Message-ID: <Pine.LNX.4.30.0110242003430.19308-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, Sven Vermeulen wrote:

> make[6]: Leaving directory `/home/nitro/src/linux/drivers/isdn/eicon'
> make -C hisax fastdep
> md5sum: WARNING: 13 of 13 computed checksums did NOT match

Been there for a while, and should be harmless.
If you really cared, you could add the new md5sums to the script
that does the checking. Can't remember why this changed without
them being updated.  Someone doing Janitor work perhaps?

> {standard input}: Assembler messages:
> {standard input}:1040: Warning: indirect lcall without `*'

AIUI, fixing these would mean breaking compilation with older versions
of binutils.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

