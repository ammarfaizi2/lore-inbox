Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSLPWdC>; Mon, 16 Dec 2002 17:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSLPWdC>; Mon, 16 Dec 2002 17:33:02 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56072 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262067AbSLPWdB>; Mon, 16 Dec 2002 17:33:01 -0500
Date: Mon, 16 Dec 2002 23:40:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Metolious hardware-sensors-using-ACPI specs
Message-ID: <20021216224057.GE20773@atrey.karlin.mff.cuni.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A5A4@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A5A4@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is it goign to be implemented in linux-acpi?
> > 
> > I took a look at specs at intel, and it has rather funny legaleese:
> 
> Wow, is that still on a website somewhere?

Yep, as someone already pointed out.

> So as you may know from looking at the spec, Metolious was a spec that
> defined a way for platforms to enumerate various motherboard sensors to the
> OS, for manageability purposes.
> 
> It never took off, except for a couple companies that used the Windows
> driver for other things because they didn't want to write a driver that
> received ACPI device Notify()s.

> The licensing may be weird, but given that there really is no point in
> implementing it on Linux, does that really matter?

Ouch, I started implementing that hour ago... [Never mind, very little
damage done so far].

But... Metolious sounds *needed*; how do you access voltage sensors
without metolious, in a way that can coexist with ACPI thermal
support?

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
