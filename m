Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261780AbSIXSBw>; Tue, 24 Sep 2002 14:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbSIXSAz>; Tue, 24 Sep 2002 14:00:55 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:14087 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S261780AbSIXR7l>; Tue, 24 Sep 2002 13:59:41 -0400
Date: Tue, 24 Sep 2002 14:04:33 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: UP IO-APIC
In-Reply-To: <Pine.GSO.4.33.0209241119500.11624-100000@sweetums.bluetronic.net>
Message-ID: <Pine.LNX.4.44.0209241359340.12397-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Ricky Beam wrote:

> It works in 2.4, but I've never seen it work in 2.5 -- but I've not compiled
> every 2.5.X.  Neither the local APIC or IO APIC work in non-SMP configurations

I've been using it since inception with local APIC, UP-IOAPIC broke a 
couple of times only.

> due to dependencies on things in mpparse.c (read: SMP functions.)  The local
> APIC makes perfect sense albeit rare.  Single processor IO APICs are very
> rare and are usually MP systems with only one processor.

... Or UP machines with chipsets with IOAPICs (Microsoft recommends 
hardware manufaturers to use one).

> APIC support in 2.5 is very closely tied to SMP. (and technically, ACPI.)

Not the case for local APIC, i'll try building .38 with UP IOAPIC.

	Zwane

-- 
function.linuxpower.ca

