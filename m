Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276004AbRI1KqM>; Fri, 28 Sep 2001 06:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276003AbRI1Kpw>; Fri, 28 Sep 2001 06:45:52 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:17683 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S276002AbRI1Kpq>;
	Fri, 28 Sep 2001 06:45:46 -0400
Date: Fri, 28 Sep 2001 12:46:11 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PnP BIOS + 2.4.9-ac16 = no boot
Message-ID: <20010928124611.H21524@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When booting a 2.4.9-ac16 kernel on my Sony Vaio C1VE laptop
the boot process hangs with something like:
	PnP: PNP BIOS installation structure at 0xc00f8120
	PnP: PNP BIOS version 1.0, entry ay f0000:b25f, dseg at 400
	general protection fault: 0000
	...
	Code: Bad EIP value

Adding nobiospnp to the kernel boot line solves the problem. The last
-ac kernel I tried (2.4.9-ac10) does not need exhibit this problem.

Since this machine's BIOS is crap anyway (almost entirely ACPI - 
APM suspend doesn't work etc), is it worth investigating this issue
or should I blame the BIOS structures once again ?

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
