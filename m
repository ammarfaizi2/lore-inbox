Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263450AbSIQBdW>; Mon, 16 Sep 2002 21:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263456AbSIQBdW>; Mon, 16 Sep 2002 21:33:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24553 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263450AbSIQBdV>;
	Mon, 16 Sep 2002 21:33:21 -0400
Date: Mon, 16 Sep 2002 18:29:24 -0700 (PDT)
Message-Id: <20020916.182924.50846771.davem@redhat.com>
To: daniel@rimspace.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: To Anyone with a Radeon 7500 board and the ali developer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <8765x5z9go.fsf@enki.rimspace.net>
References: <1032180131.1191.7.camel@irongate.swansea.linux.org.uk>
	<20020916.121423.109699832.davem@redhat.com>
	<8765x5z9go.fsf@enki.rimspace.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Pittman <daniel@rimspace.net>
   Date: Tue, 17 Sep 2002 11:33:11 +1000
   
   ...which might explain why my machine has occasional DRM related hangs,
   since there is no way for me to match the XFree86 AGP speed and the BIOS
   set AGP speed -- my BIOS will not tell me what it set, nor does it have
   a toggle to adjust it.

There's a value in the PCI config space, check out the AGP gart
code in the kernel.  I don't know it offhand.
