Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbRAKC5u>; Wed, 10 Jan 2001 21:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129939AbRAKC5k>; Wed, 10 Jan 2001 21:57:40 -0500
Received: from ns1.megapath.net ([216.200.176.4]:28427 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129777AbRAKC5c>;
	Wed, 10 Jan 2001 21:57:32 -0500
Message-ID: <3A5D20D6.6090906@megapathdsl.net>
Date: Wed, 10 Jan 2001 18:56:22 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac1 i686; en-US; m18) Gecko/20010107
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Eppert <eppertan@rose-hulman.edu>
CC: dhinds@zen.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Patch for 3c575
In-Reply-To: <20010110204420.A7699@rose-hulman.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Huh.  Well, I have a 3CCFE575BT "3c575" card and I have
had success using the 3c59x driver to enable the card.

I only have one bug I am tracking:

If I have two cardbus cards active in my cardbus slots,
the 3c59x driver locks up.  I doubt this problem would
vanish if I were using your 3c575 driver, but I will give
it a try.

There's one other annoyance:

The config files for pcmcia-cs expect the 3c575_cb driver,
so I either have to hack the configuration files or load
the 3c59x driver by hand.

In case it isn't clear, I am only using the PCMCIA/Cardbus
drivers from the 2.4.0 kernel tree (yenta and friends).
I am only using pcmcia-cs utilities and configuration files
for PCMCIA support and to give me a decent /etc/pcmcia/config.opts
file.

	Miles

Aaron Eppert wrote:

> Attached is a patch against 2.4.0 to add the 3c575 driver 
> into the kernel.  Simple reasoning for the addition involves
> the rather broad use of this card and the need to have it
> in a standard kernel.
> 
> Aaron Eppert


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
