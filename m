Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRAHKJR>; Mon, 8 Jan 2001 05:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136498AbRAHKI5>; Mon, 8 Jan 2001 05:08:57 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:28605 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S132556AbRAHKIx>;
	Mon, 8 Jan 2001 05:08:53 -0500
Message-ID: <3A5991BC.64525AF7@student.ethz.ch>
Date: Mon, 08 Jan 2001 11:09:00 +0100
From: Giacomo Catenazzi <cate@student.ethz.ch>
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: "Giacomo A . Catenazzi" <cate@dplanet.ch>, linux-kernel@vger.kernel.org
Subject: Re: Coppermine is a PIII or a Celeron?
In-Reply-To: <fa.dl37erv.6j04hb@ifi.uio.no> <fa.hcv7gqv.s3k9qk@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2001 10:08:51.0651 (UTC) FILETIME=[00119130:01C0795B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> On 2001.01.02 Giacomo A. Catenazzi wrote:
> > Hello!
> >
> > When working in cpu autoconfiguration I found some problems:
> >
> > I have to identify this processor:
> >   Vendor: Intel
> >   Family: 6
> >   Model:  8
> > Is it a "Pentium III (Coppermine)" (setup.c:1709)
> > or a "Celeron (Coppermine)" (setup.c:1650) ?
> >
> 
> AFAIK, both. Coppermine is the code name of the low level arch of
> the chip.
> 
> Really, the kernel should be querying the builder: Have you a
> Deschutes, a Mendocino or a Coppermine ? How much cache do you have ?
> But that is rarely known (Uh? I bought a Pentium III). You have to
> guess from the answer to:
> Have you a PII, an old Celeron (Mendocino) or a new Cel-PIII (Copper).
> 

Thus the older Celerons should be compiled with CONFIG_M686 (Pentium
Pro),
but the Celeron Coppermine can be compiled with CONFIG_M686FXSR (Pentium
III), right?
In this case we should update the files Configure.help and the config.in
files.

	giacomo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
