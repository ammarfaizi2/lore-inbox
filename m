Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265383AbSKACBN>; Thu, 31 Oct 2002 21:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265451AbSKACBN>; Thu, 31 Oct 2002 21:01:13 -0500
Received: from fmr02.intel.com ([192.55.52.25]:54525 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265383AbSKACBK>; Thu, 31 Oct 2002 21:01:10 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A495@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Greg KH'" <greg@kroah.com>,
       "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Lee, Jung-Ik" <jung-ik.lee@intel.com>, linux-kernel@vger.kernel.org
Subject: RE: bare pci configuration access functions ?
Date: Thu, 31 Oct 2002 18:07:31 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH [mailto:greg@kroah.com] 
> Nice, thanks for pointing that out.  But what about the fact that I
> think we can now start optimizing certain parts of the 
> "generic" code to
> play nicer with Linux?

It is much much more important that ACPI be *correct* than fast or small. To
that end, it is better to not fork ACPI-Linux from ACPI-everyone else. Linux
benefits from core bugs found by other OSes (FBSD is not the only one - for
some reason I'm not allowed to mention who else is using ACPI CA but they
*do* send bug reports) and vice versa.

> Now I don't mean this to be an ACPI rant, I know why they did 
> their code
> this way, and without it, there probably would not be any ACPI Linux
> code.  I just don't think it's the best way (from an engineering
> standpoint) to do things.  And again, we are getting way off 
> topic from
> the original problem, sorry.

I'm used to ACPI ranting from all quarters, you know that ;-) but let me
just say this:

- ACPI is not performance-critical
- ACPI will never be simple and elegant, even if you made it Linux-specific
- Portability enhances correctness and maximizes developer productivity
- Read my lips, no new taxes!

(dunno where that last one came from ;-)

Regards -- Andy
