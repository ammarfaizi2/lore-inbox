Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbRGKO3S>; Wed, 11 Jul 2001 10:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbRGKO3H>; Wed, 11 Jul 2001 10:29:07 -0400
Received: from ns.suse.de ([213.95.15.193]:29959 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267320AbRGKO26>;
	Wed, 11 Jul 2001 10:28:58 -0400
Date: Wed, 11 Jul 2001 16:28:58 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jordan <ledzep37@home.com>, Jordan Breeding <jordan.breeding@inet.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: Discrepancies between /proc/cpuinfo and Dave J's
 x86info
In-Reply-To: <Pine.LNX.4.21.0107111457010.2035-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.30.0107111625410.1811-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Hugh Dickins wrote:

> Am I paranoid?

Probably :)
The Intel CPUs with PSN I've seen simply drop 1 level.
What other CPUs support this feature? ISTR Transmeta had it?
Do they behave the same?

>  I feel nervous about "c->cpuid_level--" inferring
> what we expect to happen to it, would prefer to check it (below).
> +		c->cpuid_level = cpuid_eax(0);

No biggie, either solution is fine with me.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

