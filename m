Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHw1Nsfz1QgiTMqlRaGRHaS9xA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 15:05:38 +0000
Message-ID: <01f201c415a4$7c382290$d100000a@sbs2003.local>
Subject: Re: Pentium M config option for 2.6
Content-Class: urn:content-classes:message
From: "Rob Love" <rml@ximian.com>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@smtp.paston.co.uk>
Cc: <szepe@pinerecords.com>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <200401041227.i04CReNI004912@harpo.it.uu.se>
References: <200401041227.i04CReNI004912@harpo.it.uu.se>
Content-Type: text/plain;
	charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 29 Mar 2004 16:42:47 +0100
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:48.0828 (UTC) FILETIME=[7CF223C0:01C415A4]

On Sun, 2004-01-04 at 07:27, Mikael Pettersson wrote:


> And since P-M doesn't do SMP, does cache line size even
> matter? There are no locks to protect from ping-ponging.

Cache line size does still come into the picture on UP, albeit not as
much as with SMP - but e.g. it still matters to things like device
drivers doing DMA.

	Rob Love


