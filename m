Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262254AbRERGd4>; Fri, 18 May 2001 02:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262259AbRERGdq>; Fri, 18 May 2001 02:33:46 -0400
Received: from elin.scali.no ([195.139.250.10]:10765 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S262254AbRERGdb>;
	Fri, 18 May 2001 02:33:31 -0400
Message-ID: <3B04C232.310A30EA@scali.no>
Date: Fri, 18 May 2001 08:33:22 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: Zilvinas Valinskas <zvalinskas@carolina.rr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA/PDC/Athlon
In-Reply-To: <Pine.LNX.4.33.0105172131230.5744-100000@portland.hansa.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
> 
> Hello, Zilvinas!
> 
> There are utilities that work with PnP BIOS. They are included with
> pcmcia-cs (which is weird - it should be a separate package) and called
> "lspci" and "setpci". They depend on PnP BIOS support in the kernel
> (CONFIG_PNPBIOS).
> 
> Dumping your PnP BIOS configuration and checking whether it has changed
> after booting to Windows would be more reasonable than checking your PCI
> configuration (IMHO).

Ehm, "lspci" and "setpci" is part of the pci-utils package (at least on RedHat)
and is used to dump/modify PCI configuration space (/proc/bus/pci). If you know
how to use these tools to dump PNP bios, please tell us.

Regards
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
