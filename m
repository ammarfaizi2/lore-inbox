Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSLZBHA>; Wed, 25 Dec 2002 20:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSLZBHA>; Wed, 25 Dec 2002 20:07:00 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:60599 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S261599AbSLZBHA>; Wed, 25 Dec 2002 20:07:00 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C1AEC83@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Cleverdon'" <jamesclv@us.ibm.com>,
       "'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Martin Bligh'" <mbligh@us.ibm.com>,
       "'John Stultz'" <johnstul@us.ibm.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'Mallick, Asit K'" <asit.k.mallick@intel.com>,
       "'Saxena, Sunil'" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       "'Andi Kleen'" <ak@suse.de>, "'Hubert Mantel'" <mantel@suse.de>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m
	 ore than 8 CPUs
Date: Wed, 25 Dec 2002 19:14:41 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>One thing I will say. Your code would be a hell of a lot saner for
>merging if you mapped the ISA/Legacy IRQ's as 0-15 (to software) and the
>PCI ones to 16+ like everyone else does. That would kill a _lot_ of
>ifdefs and the IRQ0 corner case

Alan, do you mean the case implemented in the IA64 tree? I was terribly out
of time so I had to do something quick and dirty. The IRQ0 was not nearly as
bad as the rest of the legacy drivers asking for the "IRQ3" and "4" etc. I
haven't looked into other arch's implementations - who else has done it? Was
it ever case similar to ours in others?

Thanks,

--Natalie
