Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282265AbRKZTAL>; Mon, 26 Nov 2001 14:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282048AbRKZS7C>; Mon, 26 Nov 2001 13:59:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51584 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282050AbRKZS5l>;
	Mon, 26 Nov 2001 13:57:41 -0500
Date: Mon, 26 Nov 2001 10:57:31 -0800 (PST)
Message-Id: <20011126.105731.85698648.davem@redhat.com>
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-final drivers/net/bonding.c includes user space headers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C028210.719F900C@lbl.gov>
In-Reply-To: <18133.1006497103@kao2.melbourne.sgi.com>
	<3C028210.719F900C@lbl.gov>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Keith Owens wrote:
   > 
   > 2.4.15-final/drivers/net/bonding.c:188: #include <limits.h>
   > 
   > Kernel code must not include use space headers.  I thought this had
   > been fixed.  It will not compile in 2.5.
   > 

Keith I fully agree with you. I sent the fix to Linus probably 4 times
but he simply was not accepting any non-OOPS fixing patches.

It's in my queue and will go to Marcelo today.

Franks a lot,
David S. Miller
davem@redhat.com
