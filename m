Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291531AbSBHKQo>; Fri, 8 Feb 2002 05:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291532AbSBHKQe>; Fri, 8 Feb 2002 05:16:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11024 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291531AbSBHKQY>;
	Fri, 8 Feb 2002 05:16:24 -0500
Message-ID: <3C63A576.9D3AA89D@mandrakesoft.com>
Date: Fri, 08 Feb 2002 05:16:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stefan Rompf <srompf@isg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interface operative status detection
In-Reply-To: <3C498CC9.6FAED2AF@isg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Rompf wrote:
> Note that there is still sourcecode in drivers/net that plays with
> IFF_RUNNING directly. As I don't own these cards, let me just list the
> files so that the maintainers can have a look: bmac.c,
> wan/lmc/lmc_main.c, wan/comx-proto-fr.c, tlan.c, eepro100.c,
> au1000_eth.c, tokenring/ibmtr.c and bonding.c.

I recently fixed this in eepro100.c, in 2.4.18-pre9 and later.  Patches
accepted to clear up the others.


> diff -urN -X dontdiff linux-2.4.17/drivers/net/tulip/21142.c linux-2.4.17stefan/drivers/net/tulip/21142.c
> --- linux-2.4.17/drivers/net/tulip/21142.c      Fri Nov  9 22:45:35 2001
> +++ linux-2.4.17stefan/drivers/net/tulip/21142.c        Sat Jan 19 15:28:57 

thanks, patch applied and modified slightly, to 2.4 and 2.5.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
