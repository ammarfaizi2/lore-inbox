Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318766AbSHLR4e>; Mon, 12 Aug 2002 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSHLR4e>; Mon, 12 Aug 2002 13:56:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42910 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318766AbSHLR4d>;
	Mon, 12 Aug 2002 13:56:33 -0400
Date: Mon, 12 Aug 2002 10:46:48 -0700 (PDT)
Message-Id: <20020812.104648.51931717.davem@redhat.com>
To: ohrn@chl.chalmers.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: sungem 0.97 driver doesn't work with "Sun GigabitEthernet/P
 2.0" card.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208121524060.17083-100000@feline.chl.chalmers.se>
References: <Pine.LNX.4.44.0208121524060.17083-100000@feline.chl.chalmers.se>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Fredrik Ohrn <ohrn@chl.chalmers.se>
   Date: Mon, 12 Aug 2002 15:53:11 +0200 (CEST)

   gem: SW reset is ghetto.

If you get this message you won't get a working card at all.

Most likely the BIOS isn't assigning resources to the card
correctly.  Some x86 guru would need to look at PCI config
space dumps to figure out what might be going wrong.
