Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293348AbSCOVuY>; Fri, 15 Mar 2002 16:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293352AbSCOVuO>; Fri, 15 Mar 2002 16:50:14 -0500
Received: from jffdns01.or.intel.com ([134.134.248.3]:32210 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S293348AbSCOVt7>; Fri, 15 Mar 2002 16:49:59 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7D03@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Udo A. Steinberg'" <reality@delusion.de>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: [OOPS] Kernel powerdown
Date: Fri, 15 Mar 2002 13:49:44 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Udo A. Steinberg [mailto:reality@delusion.de]
> > Does the machine power off successfully using ACPI when the 
> NMI watchdog is
> > not enabled?
> 
> No, it never managed to power off with ACPI. It works with APM though.

Oh. Well then the NMI thing is a red herring. Try the latest ACPI patch from
sf.net/projects/acpi and see if that fixes things.

-- Andy
