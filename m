Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbTCTIgd>; Thu, 20 Mar 2003 03:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbTCTIgd>; Thu, 20 Mar 2003 03:36:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60078 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261327AbTCTIgc>;
	Thu, 20 Mar 2003 03:36:32 -0500
Date: Thu, 20 Mar 2003 00:44:39 -0800 (PST)
Message-Id: <20030320.004439.122331693.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: bunk@fs.tum.de, akpm@digeo.com, linux-atm-general@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-ATM-General] Re: 2.5.64-mm8: drivers/atm/idt77252.c
 doesn't compile 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303171543.h2HFhFGi012501@locutus.cmf.nrl.navy.mil>
References: <20030316154414.GB10253@fs.tum.de>
	<200303171543.h2HFhFGi012501@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Mon, 17 Mar 2003 10:43:15 -0500

   In message <20030316154414.GB10253@fs.tum.de>,Adrian Bunk writes:
   > tx_inuse was removed from struct atm_vcc in include/linux/atmdev.h but 
   > drivers/atm/idt77252.c still needs it:
   
   it doesnt need it -- it just needs to use the right member.  the following
   patch should fix the current errors.  i missed these bits during my
   earlier changes.
   
Applied, thanks Chas.
