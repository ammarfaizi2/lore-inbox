Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbSI1C4r>; Fri, 27 Sep 2002 22:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262691AbSI1C4r>; Fri, 27 Sep 2002 22:56:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24471 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262653AbSI1C4q>;
	Fri, 27 Sep 2002 22:56:46 -0400
Date: Fri, 27 Sep 2002 19:55:07 -0700 (PDT)
Message-Id: <20020927.195507.87349906.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209280258.GAA02712@sex.inr.ac.ru>
References: <20020927.193541.89132835.davem@redhat.com>
	<200209280258.GAA02712@sex.inr.ac.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Sat, 28 Sep 2002 06:58:22 +0400 (MSD)

   > This only runs at connect time
   
   ... and also at ip6_build_xmit(). Connected dgram sockets are marginal.

I said UDP/RAW.  At least believe that I am this smart :-)

Point is that current function is not tiny either, so improvement you
suggest applies both to current code and code after Yoshi's change.
