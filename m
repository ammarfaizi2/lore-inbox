Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261606AbSI2SOJ>; Sun, 29 Sep 2002 14:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSI2SOJ>; Sun, 29 Sep 2002 14:14:09 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:58612 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261606AbSI2SOJ>; Sun, 29 Sep 2002 14:14:09 -0400
Subject: Re: v2.6 vs v3.0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: james <jdickens@ameritech.net>, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jgarzik@pobox.com>, Larry Kessler <kessler@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0209291040420.2240-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209291040420.2240-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 19:24:26 +0100
Message-Id: <1033323866.13762.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 18:42, Linus Torvalds wrote:
> I can say that the IDE code is the same code that is in 2.4.x, so if 
> you're comfortable with 2.4.x wrt IDE, then you should be comfy with 
> 2.5.x too.

*NO*

The IDE code is the experimental code in 2.4-ac. It is _NOT_ the IDE
code in 2.4 and its a lot less tested. I don't think it has any
corruption bugs but it is most definitely not the base 2.4 code and has
plenty of non corruption bugs (PCMCIA hang, taskfile write hang, irq
blocking performance problems)

I use the 2.4-ac version of that code for day to day work. Thats about
as good a guarantee as I can give.

Alan

