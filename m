Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131296AbRCNEfM>; Tue, 13 Mar 2001 23:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131297AbRCNEfD>; Tue, 13 Mar 2001 23:35:03 -0500
Received: from web1306.mail.yahoo.com ([128.11.23.156]:18692 "HELO
	web1306.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131296AbRCNEet>; Tue, 13 Mar 2001 23:34:49 -0500
Message-ID: <20010314043408.24239.qmail@web1306.mail.yahoo.com>
Date: Tue, 13 Mar 2001 20:34:08 -0800 (PST)
From: Mark Swanson <swansma@yahoo.com>
Subject: 2.4.2-ac20 build fails with some pcmcia option
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

make bzImage gives this:

ld: cannot open drivers/net/pcmcia/pcmcia_net.o: No such file or
directory

with the following .config:

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set
CONFIG_PCMCIA_NETCARD=y  

I'm not sure how the 'CONFIG_PCMCIA_NETCARD=y' got set as my `make
config` only shows:

*
* PCMCIA network device support
*
PCMCIA network device support (CONFIG_NET_PCMCIA) [N/y/?] 

Hmm, I did a `make config` again and just presed 'enter' on all of the
lines and the CONFIG_PCMCIA_NETCARD=y was no longer in my .config -
though it still is in my .config.old.

It's late, maybe it was me - but I don't believe so...
(I do notice that CONFIG_NET_PCMCIA is in arch/i386/defconfig. Perhaps
it should not be)



__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices.
http://auctions.yahoo.com/
