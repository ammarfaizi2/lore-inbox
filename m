Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265322AbSKAQsB>; Fri, 1 Nov 2002 11:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSKAQsA>; Fri, 1 Nov 2002 11:48:00 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1672 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265322AbSKAQsA>; Fri, 1 Nov 2002 11:48:00 -0500
Subject: Re: serial port & ldisc: need help
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Romain Lievin <rlievin@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021101164811.GA558@free.fr>
References: <20021101164811.GA558@free.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 17:14:26 +0000
Message-Id: <1036170866.12551.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 16:48, Romain Lievin wrote:
> Hi,
> 
> I need informations about line disciplines (what are they, how to use them)...
> 
> Is there anyone who could explain this to me ?
> Or, is there any doc/book about this subject ?

I've seen no good documentation on this one. The ldisc is basically the
glue between the serial layer and whatever is above

So its

	/dev/ttyFOO --- [LDISC] --- Serial

or

	/dev/ttyFOO -----}
        ppp0    ---------}--[LDISC] -- Serial


