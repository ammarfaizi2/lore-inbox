Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293344AbSCOVpd>; Fri, 15 Mar 2002 16:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293347AbSCOVpZ>; Fri, 15 Mar 2002 16:45:25 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:53142 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S293344AbSCOVpM>; Fri, 15 Mar 2002 16:45:12 -0500
Message-ID: <3C926B56.FC147170@delusion.de>
Date: Fri, 15 Mar 2002 22:44:54 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Kernel powerdown
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7D01@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:

> > Looks like the ACPI code is simply forgetting to turn off the
> > NMI watchdog

That's right, however I don't think it should have to turn it off.

> Does the machine power off successfully using ACPI when the NMI watchdog is
> not enabled?

No, it never managed to power off with ACPI. It works with APM though.

> Theoretically we should be turning the machine off, after which I'm pretty
> sure the NMI watchdog shouldn't be an issue :)

That's what I think.

> but IIRC we are masking
> interrupts and doing some delays before turning off, so the NMI watchdog
> might not be liking that?

The problem is that it doesn't power off at all, no matter how long the
delay is ;)

> APM doesn't turn off the NMI afaik so why should ACPI have to?

Imho the problem will most likely go away when poweroff works properly
on my board. I can supply whatever info you need to make it work, too ;)

The board is an Asus A7V.

-Udo.
