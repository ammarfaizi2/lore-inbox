Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289086AbSANWIE>; Mon, 14 Jan 2002 17:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289088AbSANWHy>; Mon, 14 Jan 2002 17:07:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50447 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289086AbSANWHn>;
	Mon, 14 Jan 2002 17:07:43 -0500
Message-ID: <3C4356A9.367BC989@mandrakesoft.com>
Date: Mon, 14 Jan 2002 17:07:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the 
 elegant solution)
In-Reply-To: <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com> <20020114213732.M15139@suse.de> <20020114153844.A20537@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> Right now, neither lsmod nor the boot time messages  necessarily give you that
> information.  lsmod only works if the driver is in fact a module.  My
> /var/log/dmesg contains no message from the NIC on my motherboard.  And
> going from the driver to the config symbol isn't trivial even if you *have*
> the lsmod or dmesg information.

For network cards one needs only to issue the ETHTOOL_GDRVINFO ioctl to
find out what hardware is associated with an ethernet interface.

	Jeff


-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
