Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262275AbSI1EOm>; Sat, 28 Sep 2002 00:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262697AbSI1EOm>; Sat, 28 Sep 2002 00:14:42 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:59076 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262275AbSI1EOl>;
	Sat, 28 Sep 2002 00:14:41 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209280419.IAA02894@sex.inr.ac.ru>
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
To: davem@redhat.com (David S. Miller)
Date: Sat, 28 Sep 2002 08:19:29 +0400 (MSD)
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
In-Reply-To: <20020927.203606.32735488.davem@redhat.com> from "David S. Miller" at Sep 27, 2 08:36:06 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Alexey, I still am not clear, this belongs in the output routing logic
> right?
...
> where source address selection belongs.

Yes, it naturally belongs to the time when route is created.

This is just extending ipv6 routing entry with a field to hold
source address and, generally, making the same work as IPv4 does,
with all the advantages, particularily capability to select preferred
source address via routes set up by admin (RTA_PREFSRC attribute,
"src" in "ip route add").

Alexey
