Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSFYMxw>; Tue, 25 Jun 2002 08:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSFYMxv>; Tue, 25 Jun 2002 08:53:51 -0400
Received: from [213.237.118.130] ([213.237.118.130]:36994 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S315457AbSFYMxu>;
	Tue, 25 Jun 2002 08:53:50 -0400
From: Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
Organization: One2one Networks A/S
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre10-ac2: APM & ACPI
Date: Tue, 25 Jun 2002 14:36:57 +0200
User-Agent: KMail/1.4.5
References: <1024959550.3208.11.camel@nomade>
In-Reply-To: <1024959550.3208.11.camel@nomade>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206251436.57940.snowwolf@one2one-networks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 June 2002 00:59, Xavier Bestel wrote:
> I have an SMP Via VP6 mobo. Here is an excerpt from dmesg:
>
> apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
> apm: disabled - APM is not SMP safe (power off active).
>
> then:
>
> ACPI: APM is already active, exiting
Wierd
>
> That's weird, because I left apm only to power off the machine
> (otherwise it doesn't), knowing that it wouldn't be enabled because of
> the SMP mobo. ACPI should still work.
>
> (OTOH, I finally disabled ACPI because (after compiling without APM) it
> appears it randomly freezes or reboots my machine ..)
>
Havent you heard? Thats what ACPI-support does on linux ;-)

So power off your SMP manually or accumulate uptime like the rest of us.

(actually ACPI is more stable om SMP machines that normal ones. My ASUS A7M-D 
dual Athlon is the only machine I have ever seen survive more than 5 minutes 
with an ACPI-kernel)
