Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129237AbRAaWVr>; Wed, 31 Jan 2001 17:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129300AbRAaWV2>; Wed, 31 Jan 2001 17:21:28 -0500
Received: from selene.cps.intel.com ([192.198.165.10]:48142 "EHLO
	selene.cps.intel.com") by vger.kernel.org with ESMTP
	id <S129271AbRAaWVN>; Wed, 31 Jan 2001 17:21:13 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE61C@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: ACPI breaks maestro
Date: Wed, 31 Jan 2001 14:20:44 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do maestro and acpi share an interrupt on your machine?
If so, is maestro's ISR ever getting called? Is ACPI's ISR
(drivers/acpi/events/evsci.c acpi_ev_sci_handler()) getting called and
reporting them handled when it shouldn't?

Thanks -- Regards -- Andy

> From: Pavel Machek [mailto:pavel@suse.cz]

> With acpi support turned on, maestro does not work. Turn acpi off, and
> maestro is working, again.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
