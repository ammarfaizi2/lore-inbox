Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSAQFOM>; Thu, 17 Jan 2002 00:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288184AbSAQFOD>; Thu, 17 Jan 2002 00:14:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25988 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288174AbSAQFNz>;
	Thu, 17 Jan 2002 00:13:55 -0500
Date: Wed, 16 Jan 2002 21:12:51 -0800 (PST)
Message-Id: <20020116.211251.35505694.davem@redhat.com>
To: wilson@whack.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: hires timestamps for netif_rx()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.40.0201161827510.28457-100000@apogee.whack.org>
In-Reply-To: <20020116.170852.91311984.davem@redhat.com>
	<Pine.GSO.4.40.0201161827510.28457-100000@apogee.whack.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Wilson Yeung <wilson@whack.org>
   Date: Wed, 16 Jan 2002 18:45:02 -0800 (PST)

   Notice that all the timestamps are the same, which led me to believe that
   xtime was being gotten directly.
   
This is what happens only if your CPU lacks a timestamp counter
(TSC on x86).  What kind of CPU are you performing this experiment
on?
