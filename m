Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263148AbSJGQE3>; Mon, 7 Oct 2002 12:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263151AbSJGQE3>; Mon, 7 Oct 2002 12:04:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32922 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263148AbSJGQE2>;
	Mon, 7 Oct 2002 12:04:28 -0400
Date: Mon, 07 Oct 2002 09:02:33 -0700 (PDT)
Message-Id: <20021007.090233.107701780.davem@redhat.com>
To: nico@cam.org
Cc: rmk@arm.linux.org.uk, simon@baydel.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210071148450.913-100000@xanadu.home>
References: <20021007125755.A5381@flint.arm.linux.org.uk>
	<Pine.LNX.4.44.0210071148450.913-100000@xanadu.home>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nicolas Pitre <nico@cam.org>
   Date: Mon, 7 Oct 2002 12:05:16 -0400 (EDT)

   2) Not inlining inb() and friend reduce the bloat but then you further 
      impact performances on CPUs which are generally many order of magnitude 
      slower than current desktop machines.
   
I don't buy this one.  You are saying that the overhead of a procedure
call is larger than the overhead of going out over the I/O bus to
touch a device?
