Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132724AbRD0LhU>; Fri, 27 Apr 2001 07:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135982AbRD0LhL>; Fri, 27 Apr 2001 07:37:11 -0400
Received: from web11105.mail.yahoo.com ([216.136.131.152]:38151 "HELO
	web11105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S135942AbRD0Lg6>; Fri, 27 Apr 2001 07:36:58 -0400
Message-ID: <20010427113657.73542.qmail@web11105.mail.yahoo.com>
Date: Fri, 27 Apr 2001 04:36:57 -0700 (PDT)
From: Evan Montgomery-Recht <evanrecht@yahoo.com>
Reply-To: montge@mianetworks.net
Subject: Cardbus conflicts...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About 2 years ago, I bought a IBM 600E laptop with one
of the IBM branded Xircom CardBUS cards.  It took me
about a month (with the help of a lot of people with
simular machines) to figure out why the card would be
recognized, and even connect to the network, but could
never get a IP address from DHCP.  It turned out that
the sound card which is a one of the CS based chips. 
The fix that I found was that if I added the following
line to the /etc/pcmcia/config.opts The card would be
detected, and recognized, and get a IP address.

exclude ports 0x2f8-0x2ff

The unfortunate side effect is that I cannot seem to
get the sound card to work, even with OSS-commercial
which I had a old license for that expires soon from
when I bought a copy way back in I think 96' (what a
scary thought).

I realize that this this is a older machine, but this
is not unique, I've found over the years that every
machine I've owned has had a custom "profile" to get
all addin-cards to work.  So I leave with two
questions.

1. Does someone have a better fix for this problem
then I've been able to find?

2. It seems like there is a need to have like a
"vendor-profile" support that allows for these special
types of conflicts.  I havn't been able to find much
on this.  Is anyone aware of such a thing.

thanks,

evan

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
