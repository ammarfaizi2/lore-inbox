Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpIJ/1FpWBS+yS7qXzZPo/kmpig==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 16:34:47 +0000
Message-ID: <021301c415a4$827f09c0$d100000a@sbs2003.local>
Subject: Re: Pentium M config option for 2.6
Content-Class: urn:content-classes:message
From: "Rob Love" <rml@ximian.com>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@smtp.paston.co.uk>
Cc: "Mikael Pettersson" <mikpe@csd.uu.se>, <szepe@pinerecords.com>,
        <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20040104162516.GB31585@redhat.com>
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <1073228608.2717.39.camel@fur>  <20040104162516.GB31585@redhat.com>
Content-Type: text/plain;
	charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 29 Mar 2004 16:42:58 +0100
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:58.0359 (UTC) FILETIME=[82A07470:01C415A4]

On Sun, 2004-01-04 at 11:25, Dave Jones wrote:

> Regardless, Tomas's patch changed CONFIG_X86_L1_CACHE_SHIFT for
> that CPU, and CONFIG_X86_L1_CACHE_SHIFT shouldn't affect this.
> The cacheline size is determined at boottime using the code in
> pcibios_init() and set using pci_generic_prep_mwi().
> 
> The config option is the default that pci_cache_line_size starts at,
> but this gets overridden when the CPU type is determined.

Yah.  I was just answering in the abstract to the "does cache line
matter on non-SMP" question.

I actually like this patch (perhaps since I have a P-M :) and think it
ought to go in, although I agree with others that the P-M is more of a
super-P3 than a scaled down P4.

	Rob Love


