Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpJsvF0fYISdBTY6rbMGPaDppGQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 01:44:00 +0000
Message-ID: <028e01c415a4$9b2f88a0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:43:39 +0100
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
From: "Adrian Bunk" <bunk@fs.tum.de>
To: <Administrator@osdl.org>
Cc: "Paul Jackson" <pj@sgi.com>, <linux-kernel@vger.kernel.org>,
        <akpm@osdl.org>
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
References: <19ahq-7Rg-11@gated-at.bofh.it> <19eEs-5lC-15@gated-at.bofh.it> <19kgS-4HT-19@gated-at.bofh.it> <m3pte3i17t.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <m3pte3i17t.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:43:42.0890 (UTC) FILETIME=[9D2B58A0:01C415A4]

On Fri, Jan 02, 2004 at 02:33:10AM +0100, Andi Kleen wrote:
> Paul Jackson <pj@sgi.com> writes:
> 
> > Right now, compiling a 2.6.0-mm1 (what I had handy) with the 3.3 gcc on
> 
> That was a bug in gcc 3.3.0. It had the -Wsign-compare warning 
> enabled in -Wall by mistake. Update to gcc 3.3.1, which has this fixed.

Wrong.

It was _not_ a bug in gcc 3.3 .

It was a bug in some _prerelease_ versions of gcc 3.3 SuSE decided to 
ship in a release of their distribution.

There is no officially released version of gcc with this problem.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

