Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWHHDPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWHHDPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWHHDPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:15:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:21222 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751234AbWHHDPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:15:15 -0400
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 0/9] Replace some ARCH_HAS_XYZZY
Date: Tue, 8 Aug 2006 05:15:10 +0200
User-Agent: KMail/1.9.3
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       torvalds <torvalds@osdl.org>
References: <20060807141328.4d9c2a72.rdunlap@xenotime.net> <200608080405.11111.ak@suse.de> <20060807200804.7847e6d0.rdunlap@xenotime.net>
In-Reply-To: <20060807200804.7847e6d0.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608080515.10496.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> They are config characteristics (in many cases).  Hiding them in
> header files with dummy inlines or with ARCH_HAS_XYZZY is still
> hiding them IMO, although the inlines are better than the
> ARCH_HAS_XYZZY method.  I prefer to see them in the config space
> since I think that's where they belong.

That's just a different way to write a #define. You could as 
well keep the originals then.

-Andi
