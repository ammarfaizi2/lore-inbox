Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275482AbRJYQyy>; Thu, 25 Oct 2001 12:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275424AbRJYQyi>; Thu, 25 Oct 2001 12:54:38 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:12548 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S275482AbRJYQyb>;
	Thu, 25 Oct 2001 12:54:31 -0400
Message-ID: <3BD843DE.6FD5AF2D@nyc.rr.com>
Date: Thu, 25 Oct 2001 12:54:54 -0400
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel PCMCIA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted a while ago, and a got a partial answer so I've decided to be
more specific in my query.

Why are hotplug and cardmgr needed?  As I understand it, cardbus uses
hotplug for config/init, and other pcmcia cards use cardmgr for init and
/etc/pcmcia/* for config.  This seems like a big, smelly mess.

The only documentation I've found (on sourceforge) is a bit dated.  Can
anyone point me to some recent documentation? 

Also is anyone working on putting the "cardmgr/hotplug" functionality in
the kernel?  In my VERY HUMBLE opinion, putting this in the kernel is
akin to having PCI (or some other bus) init code in the kernel, so why
isn't this done? 
What's the deal with hotplug vs. kernel-pcmcia-cs? 

I don't use modules, so I don't use cardmgr for anything except to tell
the kernel that there is a card in the socket.

I really need a good architectural overview of this in Linux.  Any
pointers?
