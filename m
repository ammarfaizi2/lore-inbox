Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293458AbSCSBlv>; Mon, 18 Mar 2002 20:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293461AbSCSBlb>; Mon, 18 Mar 2002 20:41:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53950 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293458AbSCSBl2>;
	Mon, 18 Mar 2002 20:41:28 -0500
Date: Mon, 18 Mar 2002 17:38:03 -0800 (PST)
Message-Id: <20020318.173803.78092815.davem@redhat.com>
To: aferber@techfak.uni-bielefeld.de
Cc: torvalds@transmeta.com, Dieter.Nuetzel@hamburg.de,
        linux-kernel@vger.kernel.org
Subject: Re: 7.52 second kernel compile
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020319023755.A28383@devcon.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
   Date: Tue, 19 Mar 2002 02:37:55 +0100
   
   Erm, you forgot COW semantics. The accesses to buffer are actually all
   going to the same physical address. As CPU caches work on physical
   addresses AFAIK (everything else would be just stupid ;-), there are
   no cache misses (disregarding a few produced by IRQs/scheduling etc.).

ROFL, ignore that part of my postings then :-)
