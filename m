Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSI1FWJ>; Sat, 28 Sep 2002 01:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbSI1FWJ>; Sat, 28 Sep 2002 01:22:09 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:2757 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261661AbSI1FWI>;
	Sat, 28 Sep 2002 01:22:08 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209280526.JAA03028@sex.inr.ac.ru>
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
To: yoshfuji@linux-ipv6.org (YOSHIFUJI Hideaki /
	=?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=)
Date: Sat, 28 Sep 2002 09:26:57 +0400 (MSD)
Cc: usagi@linux-ipv6.org, davem@redhat.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <20020928.141407.110833680.yoshfuji@linux-ipv6.org> from "YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=" at Sep 28, 2 02:14:07 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> we need per application (per socket) interface
> for privacy extension (public address vs temporary address) and 
> mobile ip (home address vs care-of address).

OK. It is natural user-friendly generalization of bind(). I do not see
problems.

Though, please, explain, to avoid misunderstanding. Let's take the second
case for simplicity. Is that true that it is supposed to add
to each application a switch "home or care-of"? This sound strange enough,
taking into account that only a few of applications have switch sort of -b
in openssh despite of age of plain bind() is equal to age of internet. :-)

Alexey
