Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbTAJNEL>; Fri, 10 Jan 2003 08:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbTAJNEK>; Fri, 10 Jan 2003 08:04:10 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:11701 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265132AbTAJNEJ>;
	Fri, 10 Jan 2003 08:04:09 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15902.50901.407336.44434@harpo.it.uu.se>
Date: Fri, 10 Jan 2003 14:12:53 +0100
To: Harry Sileoni <stamina@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suggestion
In-Reply-To: <1042203152.954.7.camel@vihta>
References: <1042203152.954.7.camel@vihta>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harry Sileoni writes:
 > While fighting for some time with my Dell Inspiron 8100 laptop and a new
 > kernel. No matter what I did in the APM-settings, the computer just
 > freezed after some minutes of uptime. Now I noticed a page witch
 > informed me that APIC support should not be used. I disabled APIC
 > support from the kernel config, and now it works perfect.
 > 
 > So, I suggest you add a line "This option might make your system hang
 > randomly" to the APIC support help page, so that other innocent people
 > with the same problem don't have to do hours of fighting with the APM,
 > which really wasn't the problem as I first though. :)

1. All recent 2.5/2.4 kernels have a blacklist rule that is supposed
   to prevent the kernel from enabling the local APIC.
   That kernel version are you using? What .config?
   Doesn't the kernel boot log contain something like "Dell Inspiron
   with broken BIOS detected. Refusing to enable the local APIC"?
2. There is no "APIC support help page" that I know of.

Are you sure you didn't mean ACPI instead? APIC != ACPI but
people keep confusing the two.
