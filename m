Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273372AbRI3MlU>; Sun, 30 Sep 2001 08:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273385AbRI3MlL>; Sun, 30 Sep 2001 08:41:11 -0400
Received: from ns.suse.de ([213.95.15.193]:41477 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S273372AbRI3MlD>;
	Sun, 30 Sep 2001 08:41:03 -0400
Date: Sun, 30 Sep 2001 14:41:28 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: <sshah@progress.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Broken APIC detection 2.4.10?
In-Reply-To: <200109301126.NAA24615@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.30.0109301438320.30158-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2001, Mikael Pettersson wrote:

> >I just switched up to 2.4.10 on my Sony Vaio N505VX.
> >Local APIC disabled by BIOS -- reenabling.
> >Could not enable APIC!

> 2.4.10 merged code from 2.4-ac which (in some .configs) will attempt
> to enable the CPU's local APIC. The boot message above is printed if
> your CPU doesn't have one.

I have a Vaio Z600TEK (Same CPU iirc as above Vaio), and also get
that message.  The thing is, I'm not entirely sure the mobile P3 has
a fully working APIC.

When I tried to get oprofile to work on it, I eventually gave up,
as reading certain registers returned nonsense. Some seem ok, but
others (like the version field return -1).


regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

