Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314670AbSD1CxH>; Sat, 27 Apr 2002 22:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314671AbSD1CxH>; Sat, 27 Apr 2002 22:53:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35245 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314670AbSD1CxG>;
	Sat, 27 Apr 2002 22:53:06 -0400
Date: Sat, 27 Apr 2002 19:43:02 -0700 (PDT)
Message-Id: <20020427.194302.02285733.davem@redhat.com>
To: jd@epcnet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: VLAN and Network Drivers 2.4.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <877576231.avixxmail@nexxnet.epcnet.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jd@epcnet.de
   Date: Sat, 27 Apr 2002 22:34:09 +0200

   > We don't call it NETIF_F_VLAN because the hope is that eventually
   > it will be rare for a network device to not be able to support it.
   > Not the other day around.
   
   I don't know how many cards won't support VLAN nowadays. But i will test
   these changes with my third party driver (just recompile it against pre-2.4.19)
   and report the results.
   
This will tell us exactly nothing.  It will continue to tell us
nothing until I make the change whereby NETIF_F_VLAN_CHALLENGED is set
by default and devices known to work are updated to clear it.

Please don't bother posting the results, we know what will happen.
