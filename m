Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130230AbQKXX3v>; Fri, 24 Nov 2000 18:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130392AbQKXX3m>; Fri, 24 Nov 2000 18:29:42 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53776 "EHLO
        havoc.gtf.org") by vger.kernel.org with ESMTP id <S130230AbQKXX3a>;
        Fri, 24 Nov 2000 18:29:30 -0500
Message-ID: <3A1EF2D0.991EBFFB@mandrakesoft.com>
Date: Fri, 24 Nov 2000 17:59:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Park <apark@cdf.toronto.edu>
CC: Linux-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: changing BIOS setting
In-Reply-To: <Pine.LNX.4.21.0011241758500.12040-100000@blue.cdf.utoronto.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Park wrote:
> Is there a way to change BIOS setting (like boot sequence)
> from the kernel space?  Any pointers would be appreciated.

Yes.  All the BIOS does is configure your hardware.  Get docs on your
hardware, and you can do anything that BIOS does.  For example, if your
parallel port is disabled in BIOS, and you have the datasheet for your
southbridge, then you can "manually" enable the parallel port by writing
certain values to certain PCI config registers.

That said, it is generally a bad idea to do this sort of thing.  Unless
you have a cluster full of machines that all have a BIOS-related
problem, or similar, you should just reboot and adjust your BIOS...

Of course, if you are really motivated, you could just flash your own
BIOS.  Check out http://www.acl.lanl.gov/linuxbios/

Regards,

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
