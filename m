Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSEaWHc>; Fri, 31 May 2002 18:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316958AbSEaWHb>; Fri, 31 May 2002 18:07:31 -0400
Received: from relay01.roc.frontiernet.net ([66.133.131.34]:40857 "HELO
	relay01.roc.frontiernet.net") by vger.kernel.org with SMTP
	id <S316957AbSEaWHb>; Fri, 31 May 2002 18:07:31 -0400
Date: Fri, 31 May 2002 18:07:19 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 3c59x driver: card not responding after a while
Message-ID: <20020531180719.A1860@vaxerdec.homeip.net>
In-Reply-To: <3CF7981D.7B70609F@eed.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronny T. Lampert (EED) on Fri 31/05 17:34 +0200:
> I'm having (reproducable) problems with the 3c59x driver; after a
> while (depends on card/traffic), the card doesn't send nor receive
> anymore.

- are you using netfilter?

- cat /proc/net/dev, what does the fifo counter say when iface hung?

- it degrades over time and only after quite a bit of data pumped
  through it does it hang right? and slowly decreasing throughput right?

- I feel much better to know someone else has this bug! I thought sure I
  was crazy since I did not hear of this problem from anyone else and
  905B is very common card.

> o RH 7.2 stock (2.4.7)

wait this worked or didn't? for me 2.4.7 works fine, 2.4.17 does not.

> If you do a /etc/init.d/network restart (or ifconfig eth0 down ;
> ifconfig eth0 ... up), the card works again.

yep, same thing here...I was to try 2.4.7 3c59x.c with otherwise recent
kernel but have not got around to this yet...
