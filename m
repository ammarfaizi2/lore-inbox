Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288092AbSACA6y>; Wed, 2 Jan 2002 19:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288053AbSACA6p>; Wed, 2 Jan 2002 19:58:45 -0500
Received: from ns.suse.de ([213.95.15.193]:16138 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288096AbSACA6h>;
	Wed, 2 Jan 2002 19:58:37 -0500
Date: Thu, 3 Jan 2002 01:58:36 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Mike Castle <dalgoda@ix.netcom.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020103003748.GB28621@thune.mrc-home.com>
Message-ID: <Pine.LNX.4.33.0201030149500.5131-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Mike Castle wrote:

> I never got the impression that DMI was going to be the exclusive way of
> obtaining information, but rather, as a supplement.

In this case though, it's not just bad, it's exceptionally bad.

Taking the 5 boxes I currently have powered up as test cases..

Old quad ppro
- Wierd compaq thing, no DMI tables. So won't do a thing here.

Athlon (one of the original ones), no ISA slots
- Correct DMI tables.

Vaio laptop
- Reports what is probably its PCMCIA slot as an ISA slot

Cyrix III box, no ISA slots
- Reports 4 slots present

K6 box, with ISA slots
- Reports none.

1 in 5 gets it right. Are the odds really worth the hassle
just to keep Aunt Tillie happy ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

