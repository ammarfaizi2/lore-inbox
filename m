Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbTIUOu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 10:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTIUOu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 10:50:26 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:27186 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262419AbTIUOuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 10:50:22 -0400
From: Jos Hulzink <josh@stack.nl>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Roger Luethi <rl@hellgate.ch>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Date: Sun, 21 Sep 2003 16:50:18 +0200
User-Agent: KMail/1.5
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0309191053140.4488-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0309191053140.4488-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309211650.18881.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 Sep 2003 15:17, Geert Uytterhoeven wrote:
> If I turn off CONFIG_X86_UP_APIC I get:
> | ACPI disabled because your bios is from 00 and too old
> | You can enable it with acpi=force
> | Sony Vaio laptop detected.
>
> and ACPI is disabled. Halt doesn't work.
>
> If I then pass `acpi=force' to explicitly enable ACPI, `halt' works again
> and powers off the machine, but `reboot' causes a black screen with IDE
> disk spun down, but no restart.
>
> Gr{oetje,eeting}s,

My PIII 650 with 2000 BIOS boots linux with acpi disabled for the same reason, 
unless force ACPI support. It reboots fine with ACPI forced. The ACPI support 
of this Intel BX mobo is good, so this is a false negative IMHO. (I wonder if 
the check is correct, shouldn't it say 2000 instead of 00 ?)

Jos
