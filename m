Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262713AbSI1Ek1>; Sat, 28 Sep 2002 00:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262714AbSI1Ek0>; Sat, 28 Sep 2002 00:40:26 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:62916 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262713AbSI1Ejq>;
	Sat, 28 Sep 2002 00:39:46 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209280444.IAA02959@sex.inr.ac.ru>
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
To: yoshfuji@linux-ipv6.org (YOSHIFUJI Hideaki /
	=?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=)
Date: Sat, 28 Sep 2002 08:44:29 +0400 (MSD)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
In-Reply-To: <20020928.133019.38287529.yoshfuji@linux-ipv6.org> from "YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=" at Sep 28, 2 01:30:19 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> we need per socket preference.

What kind of? Some matching rules loaded to socket by user?

Anyway, rules established by a particular client should be separate,
it is just a generalization of bind()/IP{V6}_PKTINFO.

I am not sure that it is really interesting though. Just now I cannot
imagine what user can invent which is not covered by system-wide rules,
bind() and IP{V6}_PKTINFO. Well, if you think more hairy scheme is interesting,
feel free to implement this.

Alexey
