Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbRFZPwk>; Tue, 26 Jun 2001 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbRFZPwb>; Tue, 26 Jun 2001 11:52:31 -0400
Received: from ns.suse.de ([213.95.15.193]:60677 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265003AbRFZPwM>;
	Tue, 26 Jun 2001 11:52:12 -0400
Date: Tue, 26 Jun 2001 17:52:04 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alex Deucher <adeucher@UU.NET>, <joeja@mindspring.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: AMD thunderbird oops
In-Reply-To: <E15Euql-0003hh-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0106261748360.12691-100000@Galois.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2001, Alan Cox wrote:

> My current speculation is that the sdram setup on some of these boards can't
> actually take the full CPU spec caused by these hand tuned routines. There is
> some evidence to support that as several other boards only work with Athlon
> optimisation if you set the BIOS options to 'conservative' not 'optimised'

Interesting, and plausable theory. It would be more interesting to see
register dumps of the memory timing registers on both good and bad
systems, to see if this is the case.

Unfortunatly afair the register level specs of all the affected chipsets
are not available.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

