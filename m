Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbTDFSJS (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 14:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTDFSJO (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 14:09:14 -0400
Received: from pop.gmx.de ([213.165.65.60]:36758 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263048AbTDFSJN (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 14:09:13 -0400
Message-ID: <3E906FF5.202@gmx.net>
Date: Sun, 06 Apr 2003 20:20:37 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poweroff problem
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>	<20030406233319.042878d3.sfr@canb.auug.org.au>	<20030406155814.68c5c908.us15@os.inf.tu-dresden.de>	<20030407002703.16993dc4.sfr@canb.auug.org.au>	<20030406174655.592b7f60.us15@os.inf.tu-dresden.de>	<1049639095.963.0.camel@dhcp22.swansea.linux.org.uk>	<20030406183713.3435d742.us15@os.inf.tu-dresden.de>	<1049642082.1218.3.camel@dhcp22.swansea.linux.org.uk> <20030406200411.2c33a06f.us15@os.inf.tu-dresden.de>
In-Reply-To: <20030406200411.2c33a06f.us15@os.inf.tu-dresden.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo A. Steinberg wrote:
> On 06 Apr 2003 16:14:42 +0100 Alan Cox (AC) wrote:
> 
> AC> Different options for reboot (16 v 32) perhaps, might even be something is
> AC> random as which way the carry flag is when the bios code is called. If you
> AC> want to be sure for the APM case stick a printk just before we drop into
> AC> the BIOS and make sure we oops after and not before..
> 
> I just tried with APM; machine powers down without problems. It's ACPI which
> doesn't power down. Last thing it prints during powerdown is:
> 
> hwsleep-0178 [-24] Acpi_enter_sleep_state: Entering S5
> 
> I can't find any specific A7V workarounds in 2.5.66 ACPI code, so I guess
> the ACPI code in 2.4 isn't up-to-date.
> 
> The original poster's problem is then probably indeed related to a buggy BIOS
> if it doesn't even powerdown with APM.

The original poster said his kernel was 2.4.2-2, which looks like a 
RedHat one and could have contained ACPI...

Regards,
Carl-Daniel

