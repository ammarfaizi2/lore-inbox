Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317304AbSFCH7J>; Mon, 3 Jun 2002 03:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSFCH7J>; Mon, 3 Jun 2002 03:59:09 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:30738 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317304AbSFCH7I>; Mon, 3 Jun 2002 03:59:08 -0400
Message-ID: <3CFB21C5.27BBFB66@aitel.hist.no>
Date: Mon, 03 Jun 2002 09:59:01 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.18-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: "Ronny T. Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>,
        linux-kernel@vger.kernel.org
Subject: Re: 3c59x driver: card not responding after a while
In-Reply-To: <3CF7981D.7B70609F@eed.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ronny T. Lampert (EED)" wrote:
> 
> Hello,
> 
> I'm having (reproducable) problems with the 3c59x driver; after a while
> (depends on card/traffic), the card doesn't send nor receive anymore.
> 
I see this too.  I always thought it was the less-than-perfect ABIT BP6
loosing an irq or something.  (odd that it _always_ is the NIC that goes
though...)  I also have a k6 with the same NIC, and another
UP machine at work.  They never fail this way.
Could it be a SMP problem?

> If you do a /etc/init.d/network restart (or ifconfig eth0 down ;
> ifconfig eth0 ... up), the card works again.

That never helped me - "shutdown -r now" is my way to recovery.
The card driver is compiled in, perhaps I should try 
making it modular and unload/reload.

Helge Hafting
