Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSGOAKw>; Sun, 14 Jul 2002 20:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSGOAKv>; Sun, 14 Jul 2002 20:10:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1783 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315293AbSGOAKu> convert rfc822-to-8bit; Sun, 14 Jul 2002 20:10:50 -0400
Subject: Re: apm power_off on smp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Pozsar Balazs <pozsy@uhulinux.hu>,
       Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1026691525.2077.38.camel@bip>
References: <Pine.GSO.4.30.0207150101150.27346-100000@balu> 
	<1026693542.13885.94.camel@irongate.swansea.linux.org.uk> 
	<1026689642.2077.21.camel@bip> 
	<1026694644.13885.99.camel@irongate.swansea.linux.org.uk> 
	<1026691525.2077.38.camel@bip>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Jul 2002 02:23:07 +0100
Message-Id: <1026696187.13886.102.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 01:05, Xavier Bestel wrote:
> Err .. my mobo's BIOS is SMP specific and implements APM, so I guess
> there is a case where it's useful. It must be something like when

Don't bet on that. I've seen quad Xeon servers with single CPU only APM

> running Win95, which is UP only. Isn't Linux able to return to a UP-like
> state (à la Win95) just before entering poweroff ?

We can flush the caches and pray, but what the BIOS does is an
interesting question. On the theory thats its your data you have to
select the chances you wish to take. (Indeed on -ac you can enable APM
on SMP in full)

