Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHw8YjE2igfdSF2mGgMmDeB9aw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 14:14:43 +0000
Message-ID: <01fa01c415a4$7c3f4e80$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:42:47 +0100
From: "Mikael Pettersson" <mikpe@csd.uu.se>
To: <Administrator@smtp.paston.co.uk>
Subject: Re: Pentium M config option for 2.6
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:47.0687 (UTC) FILETIME=[7C440970:01C415A4]

On Date: Sun, 4 Jan 2004 13:33:58 +0100, Tomas Szepe wrote:
> > IOW, don't lie to the compiler and pretend P-M == P4
> > with that -march=pentium4.
> 
> What do you recommend to use as march then?  There is
> no pentiumm subarch support in gcc yet;  I was convinced
> p4 was the closest match.

march=pentium3 is the closest safe choice, at least
until gcc implements P-M specific support.

/Mikael
