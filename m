Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273448AbRINSye>; Fri, 14 Sep 2001 14:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273446AbRINSyY>; Fri, 14 Sep 2001 14:54:24 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:60424 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S273445AbRINSyT>;
	Fri, 14 Sep 2001 14:54:19 -0400
Date: Fri, 14 Sep 2001 12:50:54 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Val Henson <val@nmt.edu>, becker@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
Message-ID: <20010914125054.A23502@ftsoj.fsmlabs.com>
In-Reply-To: <20010913195141.B799@boardwalk> <Pine.LNX.3.96.1010914014755.8683B-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.96.1010914014755.8683B-100000@mandrakesoft.mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Sep 14, 2001 at 01:49:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only the PPC-based gemini board uses that driver (ncr885e) and Val is the
maintainer of that board.  These patches that she sent fix yellowfin.c for
the ncr885e chip on the big-endian PPC.  I just pointed at the junk pile,
Val is actually doing the work to put the ncr885e drivers there.

This is a truly rare patch, it allows the removal of entire drivers
not just a few lines.  As an encore I suggest combining the >5 Zilog 8530
drivers.

} I may be missing some context... have you tested yellowfin on big endian
} boxes?  If so, go ahead and remove it.  Cort said it was destined for
} the scrapheap a while ago, and IIRC it disappeared from the 'ac' tree
} for a while...
