Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273577AbRIYVCo>; Tue, 25 Sep 2001 17:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273586AbRIYVCY>; Tue, 25 Sep 2001 17:02:24 -0400
Received: from gigi.excite.com ([199.172.152.110]:64703 "EHLO gigi.excite.com")
	by vger.kernel.org with ESMTP id <S273577AbRIYVCW>;
	Tue, 25 Sep 2001 17:02:22 -0400
Message-ID: <5440106.1001451456929.JavaMail.imail@tiptoe>
Date: Tue, 25 Sep 2001 13:57:13 -0700 (PDT)
From: Thomas Hood <thood@excite.com>
Reply-To: <jdthoodREMOVETHIS@mail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] airo.c code formatting
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Excite Inbox
X-Sender-Ip: 128.220.30.154
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DO NOT REPLY TO THIS EMAIL BUT TO:  jdthood_AT_yahoo.co.uk

>        Ok...  I've been meaning to ask something about this.  I've
> been working with the Aironet cards on some wireless security projects.
> I had been using a patched version of the aironet driver from the pcmcia
> project with the 2.2 kernels but recently started looking at the 2.4.x
> kernels and the drivers included there in.
>        I'm a bit confused by this:

> [mhw@alcove linux]$ find . -name airo\*
> ./drivers/net/aironet4500.h
> ./drivers/net/aironet4500_core.c
> ./drivers/net/pcmcia/aironet4500_cs.c
> ./drivers/net/aironet4500_card.c
> ./drivers/net/aironet4500_proc.c
> ./drivers/net/aironet4500_rid.c

The above are the "old" kernel Aironet drivers.

> ./drivers/net/wireless/airo.c
> ./drivers/net/wireless/airo_cs.c

These are the "new" kernel Aironet drivers.
These files are unrelated to those above.

These files appear to be newer than either those in pcmcia-cs
or those in the latest (1.5.000) Cisco driver, which are based on
the same original code.

The advantage of the pcmcia-cs drivers is that they work with
earlier kernels.

The advantage of the Cisco drivers is that they are Cisco-approved [tm].

--
Thomas Hood
DO NOT REPLY TO THIS EMAIL BUT TO: jdthood_AT_yahoo.co.uk





_______________________________________________________
Send a cool gift with your E-Card
http://www.bluemountain.com/giftcenter/


