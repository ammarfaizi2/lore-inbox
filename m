Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSFXPLF>; Mon, 24 Jun 2002 11:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSFXPLD>; Mon, 24 Jun 2002 11:11:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10462 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314078AbSFXPK7>;
	Mon, 24 Jun 2002 11:10:59 -0400
Date: Mon, 24 Jun 2002 08:04:09 -0700 (PDT)
Message-Id: <20020624.080409.79615643.davem@redhat.com>
To: alex@PolesApart.wox.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D173578.5080205@PolesApart.wox.org>
References: <E17MUf8-00088K-00@the-village.bc.nu>
	<3D173578.5080205@PolesApart.wox.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
   Date: Mon, 24 Jun 2002 12:06:32 -0300
   
   Maybe I got it the wrong way, but it seems to me that from your point of 
   view, as long as proprietary driver is in use, it's not anyone else 
   problem but to the vendor, even if the bug could happen to be in the 
   kernel, is that right? If so, everyone else in this list who could try 
   to fix this (again assuming it could be something related to the kernel 
   and not to the proprietary driver) necessarily share your oppinion? (I'm 
   not flaming in here, just trying to get the path).

This has to do with facts, not opinions.  Since we lack the source to
their drivers, we have no idea if some bug in their driver is
scribbling over (ie. corrupting) memory.  It is therefore an unknown
which makes it a waste of time for us to pursue the bug report.
