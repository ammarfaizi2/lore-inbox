Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSAXOYD>; Thu, 24 Jan 2002 09:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288059AbSAXOXy>; Thu, 24 Jan 2002 09:23:54 -0500
Received: from gw.wmich.edu ([141.218.1.100]:41399 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S287946AbSAXOXl>;
	Thu, 24 Jan 2002 09:23:41 -0500
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020124125914.0B3ED13D1@shrek.lisa.de>
In-Reply-To: <Pine.LNX.4.40.0201232018530.2202-100000@infcip10.uni-trier.de>
	<E16TZhr-00049f-00@mxng04.kundenserver.de> 
	<20020124125914.0B3ED13D1@shrek.lisa.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 09:23:32 -0500
Message-Id: <1011882217.22707.19.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I thought, ntpd would take care of the RTC:

It doesn't.  init scripts on boot sync the date to the rtc, if your date
isn't near what it should be then ntp wont work.  It has to at least be
close then run date --systohc or something like that. 

