Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSD2PKw>; Mon, 29 Apr 2002 11:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312494AbSD2PKv>; Mon, 29 Apr 2002 11:10:51 -0400
Received: from fmr01.intel.com ([192.55.52.18]:10949 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S312486AbSD2PKv>;
	Mon, 29 Apr 2002 11:10:51 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7DE8@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'tomas szepe'" <kala@pinerecords.com>, dmacbanay@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: RE: ACPI in 2.5 kills kbd on Via-ACPI systems [Re: kernel 2.5.10 
	problems]
Date: Mon, 29 Apr 2002 08:10:43 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: tomas szepe [mailto:kala@pinerecords.com] 
> You're right! I tried to point out before that my system had 
> ignored the
> keyboard since about the time of 2.5.7/2.5.8, but it didn't 
> occur to me that
> the problem could be ACPI related. Indeed, after compiling 
> 2.5.10-dj1 (2.5.10
> vanilla barfs an oops at me upon boot) w/ ACPI support turned 
> off, I found
> the system perfectly responsive again -- both mouse and keyboard work.
> 
> Thus I dare assume it's highly probable that input support 
> has been broken
> for VIA chipset-based systems by the recent ACPI changes in 2.5.x.

Yes, this is an ACPI problem. You might try the latest patch at
sf.net/projects/acpi (although it doesn't work in IOAPIC mode yet) and see
if that helps. Once we get it working better it'll get submitted.

Regards -- Andy
