Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbTIOHEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 03:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbTIOHEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 03:04:37 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:46606 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262036AbTIOHEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 03:04:34 -0400
Date: Mon, 15 Sep 2003 04:03:18 -0300
From: Gerardo Exequiel Pozzi <djgeray2k@yahoo.com.ar>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Vaio doesn't poweroff with 2.4.22
Message-Id: <20030915040318.1f8bfd18.djgeray2k@yahoo.com.ar>
In-Reply-To: <Pine.GSO.4.21.0309150835480.3191-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0309150835480.3191-100000@vervain.sonytel.be>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003 08:43:56 +0200 (MEST), Geert Uytterhoeven wrote:
>	Hi,
>
>With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
>w.r.t. power management:
>  - It doesn't poweroff anymore (screen contents are still there after the
>    powering down message)
>  - It doesn't reboot anymore (screen goes black, though)
>  - It accidentally suspended to RAM once while I was actively working on it (I
>    never managed to get suspend working, except for this `accident'). I didn't
>    see any messages about this in the kernel log.
>
>Relevant config options for 2.4.22:
>| tux$ grep acpi .config
>| # ACPI Support
>| CONFIG_ACPI=y
>| # CONFIG_ACPI_HT_ONLY is not set
>| CONFIG_ACPI_BOOT=y
>| CONFIG_ACPI_BUS=y
>| CONFIG_ACPI_INTERPRETER=y
>| CONFIG_ACPI_EC=y
>| CONFIG_ACPI_POWER=y
>| CONFIG_ACPI_PCI=y
>| CONFIG_ACPI_SLEEP=y
>| CONFIG_ACPI_SYSTEM=y
>| CONFIG_ACPI_AC=y
>| CONFIG_ACPI_BATTERY=y
>| CONFIG_ACPI_BUTTON=y
>| CONFIG_ACPI_FAN=y
>| CONFIG_ACPI_PROCESSOR=y
>| CONFIG_ACPI_THERMAL=y
>| # CONFIG_ACPI_ASUS is not set
>| # CONFIG_ACPI_TOSHIBA is not set
>| CONFIG_ACPI_DEBUG=y
>| # CONFIG_ACPI_RELAXED_AML is not set
>| tux$ 
>
>If you need more information or want me to ttry something, please ask!

Hi,

 you have activate this opcion?
CONFIG_PM=y

without this my machine don't poweroff after halt.

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
