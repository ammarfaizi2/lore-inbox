Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbTBVQtO>; Sat, 22 Feb 2003 11:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTBVQtO>; Sat, 22 Feb 2003 11:49:14 -0500
Received: from maile.telia.com ([194.22.190.16]:52940 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S267042AbTBVQtN>;
	Sat, 22 Feb 2003 11:49:13 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Date: Sat, 22 Feb 2003 17:57:59 +0100 (CET)
Message-Id: <20030222.175759.127093070.cfmd@swipnet.se>
To: alan@lxorguk.ukuu.org.uk
Cc: mikpe@user.it.uu.se, davidsen@tmr.com, linux-kernel@vger.kernel.org
Subject: Re: Module loading on demand
From: Magnus Danielson <cfmd@swipnet.se>
In-Reply-To: <1045935675.4721.1.camel@irongate.swansea.linux.org.uk>
References: <200302221545.h1MFjmkW006417@harpo.it.uu.se>
	<1045935675.4721.1.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 3.1 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Module loading on demand
Date: 22 Feb 2003 17:41:15 +0000

> The other nasty is that if you install Rusty's rpms for the better module tools, and
> then install a Red Hat kernel errata your errata kernel will not boot because the
> Rusty tools replace insmod.static with a tool which only works standalone on 2.5. Its
> not a big deal since most people who build 2.5 kernels build their own 2.4 ones too,
> and you can fix the initrd by hand, but it is one to know about.

The solution in Debian was to include both the 2.4 and 2.5 variants. There
where a bug in that, since initrd-tools forgot to include it, which is now
resolved. The correct variant was used depending on which kernel where
installed. A neater solution where to include the correct tools and modules
for kernel.

Cheers,
Magnus
