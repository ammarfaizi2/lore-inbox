Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbTCEOjj>; Wed, 5 Mar 2003 09:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbTCEOjj>; Wed, 5 Mar 2003 09:39:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42681 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266686AbTCEOjj>;
	Wed, 5 Mar 2003 09:39:39 -0500
Date: Wed, 05 Mar 2003 06:31:58 -0800 (PST)
Message-Id: <20030305.063158.53514369.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303051447.h25ElcGi006199@locutus.cmf.nrl.navy.mil>
References: <20030303230706.R2791@almesberger.net>
	<200303051447.h25ElcGi006199@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Wed, 05 Mar 2003 09:47:38 -0500

   In message <20030303230706.R2791@almesberger.net>,Werner Almesberger writes:
   >see getting moved to net/core/skbuff.c, because it seems to provide
   >a reasonably generic function.
   
   it has been suggested to me that the locking in skb_migrate might not be
   completely correct.  any comments on the following?
   
If you own both objects, why lock anything?
