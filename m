Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280434AbRJaTZ5>; Wed, 31 Oct 2001 14:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280433AbRJaTZr>; Wed, 31 Oct 2001 14:25:47 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:64205 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S280439AbRJaTZn>; Wed, 31 Oct 2001 14:25:43 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D6DA@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Alex Bligh - linux-kernel'" <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: RE: 2xQ: Is PM + ACPI but /no/ APM a valid configuration? Interru
	pts enabled in APM set power state?
Date: Wed, 31 Oct 2001 11:26:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Bligh - linux-kernel [mailto:linux-kernel@alex.org.uk]
> PM, ACPI, no APM
> 
> This is the wierd one. I get a pile of scrolly
> messages which I think is ACPI debugging
> and appear to be uninterruptible - SysRq K crashes
> the machine. They are attached at the bottom.
> 
> Is this a valid configuration? I can't see why
> not.

If I may interpret the debug messages...do they go away if you compile in
the ACPI embedded controller driver? That appears to be part (if not all) of
the problem.

Regards -- Andy
