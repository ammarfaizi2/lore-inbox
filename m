Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265751AbSKFQDU>; Wed, 6 Nov 2002 11:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265749AbSKFQDU>; Wed, 6 Nov 2002 11:03:20 -0500
Received: from line106-150.adsl.actcom.co.il ([192.117.106.150]:10961 "HELO
	mail.bard.org.il") by vger.kernel.org with SMTP id <S265751AbSKFQDT>;
	Wed, 6 Nov 2002 11:03:19 -0500
Date: Wed, 6 Nov 2002 18:09:34 +0200
From: "Marc A. Volovic" <marc@bard.org.il>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Marc A. Volovic" <marc@bard.org.il>,
       Pannaga Bhushan <bhushan@multitech.co.in>, linux-kernel@vger.kernel.org
Subject: Re: A hole in kernel space!
Message-ID: <20021106160934.GA25325@glamis.bard.org.il>
References: <20021106134935.GA24234@glamis.bard.org.il> <Pine.LNX.3.95.1021106085810.3962A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021106085810.3962A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux glamis 2.4.20-pre10-ac2
X-message-flag: 'Oi! Muy Importante! Get yourself a real email client. http://www.mutt.org/'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Richard B. Johnson:

> You know, I hope, that you can kmalloc(GFP_KERNEL) something in
> init_module() and it will always be resident in the kernel until
> you kfree() it in cleanup_module(). You do not have to
> allocate/deallocate every time your module does something.

I do not alloc/dealloc every time ;-). I allocate at boot and do not
bother deallocating at all. The module just uses that allocated memory
and maps it into the filesystem namespace.

>    Bush : The Fourth Reich of America

Errr, not that I care, but as far as I know, America had not yet had
even its first Reich. ;-)... Germany had three, so a forth Reich might
have been there...

-- 
---MAV
                        Linguists do it cunningly
Marc A. Volovic                                             marc@bard.org.il
