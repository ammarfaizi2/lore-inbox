Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310394AbSCGQS0>; Thu, 7 Mar 2002 11:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310392AbSCGQSR>; Thu, 7 Mar 2002 11:18:17 -0500
Received: from ns.suse.de ([213.95.15.193]:37645 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310398AbSCGQR5>;
	Thu, 7 Mar 2002 11:17:57 -0500
Date: Thu, 7 Mar 2002 17:17:56 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Luca Montecchiani <luca.montecchiani@teamfab.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux 2.2.21pre[23]
Message-ID: <20020307171756.F29587@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Luca Montecchiani <luca.montecchiani@teamfab.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C878FC8.86FCC3@teamfab.it> <E16j0fe-0002m9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16j0fe-0002m9-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 07, 2002 at 04:23:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 04:23:10PM +0000, Alan Cox wrote:
 > > Unable to handle kernel paging request at virtual address 756e654f
 > Thats not good. We tried to use a piece of ascii text as a pointer 8)

 "une0". Hmm. First guess was it was part of "unexpected interrupt",
 but thats the wrong case.

 > > my 0.2 euro on: [Backport a lot of x86 setup] ;)
 > Ditto - especially the MCE changes.

 I just did a quick glance at the code, and realised I goofed, and
 AMD & Centaur CPUs won't get to the mcheck_init call.
 Unrelated to this incident, but a problem all the same.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
