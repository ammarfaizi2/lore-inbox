Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131851AbRBAVTD>; Thu, 1 Feb 2001 16:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131847AbRBAVSx>; Thu, 1 Feb 2001 16:18:53 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2564 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131789AbRBAVSt>;
	Thu, 1 Feb 2001 16:18:49 -0500
Message-ID: <20010201103620.A121@bug.ucw.cz>
Date: Thu, 1 Feb 2001 10:36:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: ACPI breaks maestro
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE61C@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE61C@orsmsx35.jf.intel.com>; from Grover, Andrew on Wed, Jan 31, 2001 at 02:20:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Do maestro and acpi share an interrupt on your machine?

No.


...and problem went away. Now I have both maestro and ACPI, and
maestro works. It did not... Strange.

> If so, is maestro's ISR ever getting called? Is ACPI's ISR
> (drivers/acpi/events/evsci.c acpi_ev_sci_handler()) getting called and
> reporting them handled when it shouldn't?
> 
> Thanks -- Regards -- Andy
> 
> > From: Pavel Machek [mailto:pavel@suse.cz]
> 
> > With acpi support turned on, maestro does not work. Turn acpi off, and
> > maestro is working, again.

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
