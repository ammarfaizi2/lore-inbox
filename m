Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289809AbSA2SjC>; Tue, 29 Jan 2002 13:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289812AbSA2Sis>; Tue, 29 Jan 2002 13:38:48 -0500
Received: from ns.suse.de ([213.95.15.193]:4615 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289809AbSA2Shi>;
	Tue, 29 Jan 2002 13:37:38 -0500
Date: Tue, 29 Jan 2002 19:37:37 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Pete Wyckoff <pw@osc.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] typo in i386 machine check code
In-Reply-To: <20020129132532.B10960@osc.edu>
Message-ID: <Pine.LNX.4.33.0201291935370.14218-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Pete Wyckoff wrote:

>     kernel: CPU 3: Machine Check Exception: 0000000000000007
>     kernel: Bank 0: b678600022000800 at 3678600022000800
>
> The part after the "at" is supposed to be the memory address which
> was being accessed when the fault was detected.  Instead the code
> prints out the status field again (with the high bit removed for
> no apparent reason).
> Patch is against 2.5.2.

Patch is correct. I pushed the same fix to Marcelo & Linus
about a month back.  Alan, 2.2 also needs this. (Can't remember if
I told you, or you told me 8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

