Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpP7rXz6ChwS6TS2gk1fytqlIpg==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Tue, 06 Jan 2004 06:08:23 +0000
Message-ID: <049201c415a4$feebc2a0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:46:26 +0100
From: "Jakob Oestergaard" <jakob@unthought.net>
To: <Administrator@smtp.paston.co.uk>
Cc: "Mikael Pettersson" <mikpe@csd.uu.se>, <akpm@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Pentium M config option for 2.6
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Tomas Szepe <szepe@pinerecords.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <20040104123358.GB24913@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20040104123358.GB24913@louise.pinerecords.com>
User-Agent: Mutt/1.3.28i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:46:29.0171 (UTC) FILETIME=[0047D030:01C415A5]

On Sun, Jan 04, 2004 at 01:33:58PM +0100, Tomas Szepe wrote:
> On Jan-04 2004, Sun, 13:27 +0100
> Mikael Pettersson <mikpe@csd.uu.se> wrote:
> 
> > IOW, don't lie to the compiler and pretend P-M == P4
> > with that -march=pentium4.
> 
> What do you recommend to use as march then?  There is
> no pentiumm subarch support in gcc yet;  I was convinced
> p4 was the closest match.

Use the same as for P-III.

The P-M has the same instruction decoder (and execution unit) setup as
the P-III, which is *very* different from P-IV (which has one decoder
only, and then a trace cache for the decoded uops).  This is an
important difference from a code generator point of view.

>From reading Intel's optimization guides, it seems to me like the P-M is
pretty much just a slightly enhanced P-III (more cache AFAIR) which
happens to get shipped with a good mobile chipset - and that package
together is called Centrino.

That would also explain why Centrino leaves the P-IV based laptops in
the dust ;)

Cheers,

 / jakob

