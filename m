Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136146AbRD0Rsm>; Fri, 27 Apr 2001 13:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136144AbRD0Rsd>; Fri, 27 Apr 2001 13:48:33 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61106 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136139AbRD0RsY>;
	Fri, 27 Apr 2001 13:48:24 -0400
Message-ID: <3AE9B0E2.ECEBAD76@mandrakesoft.com>
Date: Fri, 27 Apr 2001 13:48:18 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: montge@mianetworks.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cardbus conflicts...
In-Reply-To: <20010427113657.73542.qmail@web11105.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evan Montgomery-Recht wrote:
> 
> About 2 years ago, I bought a IBM 600E laptop with one
> of the IBM branded Xircom CardBUS cards.  It took me
> about a month (with the help of a lot of people with
> simular machines) to figure out why the card would be
> recognized, and even connect to the network, but could
> never get a IP address from DHCP.  It turned out that
> the sound card which is a one of the CS based chips.
> The fix that I found was that if I added the following
> line to the /etc/pcmcia/config.opts The card would be
> detected, and recognized, and get a IP address.
> 
> exclude ports 0x2f8-0x2ff

What kernel are you running?  You may need to go to
http://pcmcia-cs.sourceforge.net/ for support, not there.

For kernel 2.4, make sure you have the following options set, exactly as
I present them, in your kernel .config file.

CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_I82365 is not set

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
