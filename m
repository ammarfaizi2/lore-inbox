Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319107AbSH2A0S>; Wed, 28 Aug 2002 20:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319102AbSH2A0S>; Wed, 28 Aug 2002 20:26:18 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:45703 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S319100AbSH2A0R>;
	Wed, 28 Aug 2002 20:26:17 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208290032.EAA25255@sex.inr.ac.ru>
Subject: Re: [PATCH]  IPv6 Prefix List support for 2.5.31
To: kumarkr@us.ibm.com (Krishna Kumar)
Date: Thu, 29 Aug 2002 04:32:22 +0400 (MSD)
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <OF37F86F02.E05B3694-ON88256C23.0080D178@boulder.ibm.com> from "Krishna Kumar" at Aug 28, 2 04:55:35 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> - Routing table will have lots of address prefixes that are not available
>   to the local interface addresses.

Well, all the direct routes are prefixes by definition.


> - To be a prefix list entry, it should come via an RA.

Wrong. But this does not matter, RA routes may be tagged with a flag.


> -  Also, the search over a longer routing table across all nodes is more
>    time consuming.

Do you jest? You compare linear search with lookup in radix tree. :-)

Alexey
