Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWBDTY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWBDTY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWBDTY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:24:56 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:13903 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932546AbWBDTYz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:24:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eFkzVYK6e6JKJfe333m4cRfl9AHgkkEwmmmpSFQKVeh4rikTLUoZxys4Y8PhAaXnA6SI3QgHryOFfW+hHNhsWRC95OeA2GePwGCs2E9TcD75wTqgpzqiFtTG6xtYsiKxayv9jH0rmVaaJEXYP2D/I6njldEjL5uZLFe+XJ62aC0=
Message-ID: <58d0dbf10602041124h72b2ef0fi@mail.gmail.com>
Date: Sat, 4 Feb 2006 20:24:51 +0100
From: Jan Kiszka <jan.kiszka@googlemail.com>
To: s.schmidt@avm.de
Subject: Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       linux-kernel@vger.kernel.org, opensuse-factory@opensuse.org,
       kkeil@suse.de
In-Reply-To: <200602041627.k14GR6Pa019822@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <OF7A130C3D.76EBAB24-ONC125710A.003AC847-C125710A.005A1B7D@avm.de>
	 <200602041627.k14GR6Pa019822@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/2/4, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu>:
> On Fri, 03 Feb 2006 17:24:10 +0100, s.schmidt@avm.de said:
>
> > If it is no longer possible to have non-GPL USB drivers, we shall have to
> > drop our Linux support for all AVM USB devices. We would even have to
> > discontinue the 802.11g++ WLAN USB device driver Linux developement.
>
> Why is there a problem releasing a GPL'ed USB driver?  That would solve

...especially compared to other vendors how do have open source WLAN
USB drivers these days?

> your problem just as well.  If you were really ambitious, you could clean
> up the code and submit it for inclusion in the mainline tree - thus lowering
> your support costs.
>

...and improve the code quality at the same time.

I had some trouble with the closed source fritz card dsl 2.0 driver
e.g. which suffers from a race on recent kernels (I guess Karsten Keil
informed you meanwhile). This should have been tracked down easier and
earlier (last worked on 2.6.8) if your drivers were part of the kernel
or at least taking part in the community.

I really like your hardware, but I dislike such license models.

> > This mail is not intended to provoke a discussion of open vs closed source.
> > The only intention of this mail is to make you aware of the consequences of
> > such a decision.

I tell you my opinion but I will not accept any discussion???

Well, I guess it's not your own decision that AVM is still stuck on
closed Linux drivers, your management may it's own ideas about it as
well. But who else should try to change this than the "engineer at the
front"? This is how many success stories of companies in the open
source domain took off.

I don't know your market, so I may neglect that you have to protect IP
very strictly from nosy competitors. But what part of this IP really
has to be inside the kernel driver? Can you explain this to the Linux
community? This may help a bit to understand your issues with free
drivers.

Jan
