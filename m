Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279570AbRKFTij>; Tue, 6 Nov 2001 14:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279568AbRKFTi3>; Tue, 6 Nov 2001 14:38:29 -0500
Received: from [192.55.52.18] ([192.55.52.18]:36067 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S280475AbRKFTiR>;
	Tue, 6 Nov 2001 14:38:17 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D6FD@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Martin Eriksson'" <nitrax@giron.wox.org>, linux-kernel@vger.kernel.org
Subject: RE: ACPI "hlt" mode and SMP systems?
Date: Tue, 6 Nov 2001 11:38:02 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Martin Eriksson [mailto:nitrax@giron.wox.org]
> When will the equivalence of "hlt" (in APM) work in ACPI SMP 
> systems? Or
> does it already? I have a hard time decoding all the ACPI 
> symbols, such as
> C1 C2 S0 S1 S2 S3 and so on...

The hlt instruction is an x86 thing, not an APM or ACPI thing. However, the
ACPI C1 state corresponds to using hlt. It works on ACPI SMP systems right
now.

Regards -- Andy
