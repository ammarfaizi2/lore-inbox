Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290325AbSAXV3l>; Thu, 24 Jan 2002 16:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290322AbSAXV3V>; Thu, 24 Jan 2002 16:29:21 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:20650 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290323AbSAXV3T> convert rfc822-to-8bit; Thu, 24 Jan 2002 16:29:19 -0500
Date: Thu, 24 Jan 2002 22:29:15 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: Rasmus =?iso-8859-1?Q?B=F8g?= Hansen <moffe@amagerkollegiet.dk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a
 chipset)
In-Reply-To: <200201241749.g0OHnbG02468@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Message-ID: <Pine.LNX.4.40.0201242223490.9957-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Wayne Whitney wrote:

> In mailing-lists.linux-kernel, Rasmus Bøg Hansen wrote:
>
> I have an ASUS A7V motherboard, similar to your ASUS A7V133.  I find
> that stock kernel (2.4.18-pre7) APM powers off the machine, but stock
> kernel ACPI does not.  However, the Intel ACPI patch, available from
> http://developer.intel.com/technology/IAPC/acpi/downloads.htm against
> kernel 2.4.16, does power down my machine.  I was able to forward port
> this to 2.4.18-pre7 without too much trouble by starting with 2.4.16,
> applying the Intel ACPI patch first, and then applying kernel
> patch-2.4.17 and kernel patch-2.4.18-pre7.

ok .. .maybe someone should look what the differences for the "halt"
functions are ... i risked a short look in the acpi sources, but i have
not the time to compare the patches at the moment ... maybe at the weekend
... but the acpi sources don't look like easy to understand :) (like many
parts of ther kernel ... imha as a kernel newbee :) )

>
> As to the merits of the amd_disconnect patch that started this thread,
> under 2.4.18-pre7-acpi, I get an idle CPU temperature of about 48 C.
> With the amd_disconnect patch, it drops to 32-35 C, wow!  As
> previously discussed, APM + amd_disconnect on an Athlon does not
> provide any power savings, one needs ACPI + amd_disconnect.

ahh ...  anopther "it works"- feedback ... :)


daniel

