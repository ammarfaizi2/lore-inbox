Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270178AbRINUUO>; Fri, 14 Sep 2001 16:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270201AbRINUUE>; Fri, 14 Sep 2001 16:20:04 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:63748 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S270178AbRINUUB>;
	Fri, 14 Sep 2001 16:20:01 -0400
Date: Fri, 14 Sep 2001 14:20:03 -0600
From: Val Henson <val@nmt.edu>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endian-ness bugs in yellowfin.c
Message-ID: <20010914142002.A7477@boardwalk>
In-Reply-To: <20010913195141.B799@boardwalk> <Pine.LNX.3.96.1010914014755.8683B-100000@mandrakesoft.mandrakesoft.com> <20010914125054.A23502@ftsoj.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010914125054.A23502@ftsoj.fsmlabs.com>; from cort@fsmlabs.com on Fri, Sep 14, 2001 at 12:50:54PM -0600
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Removed Donald Becker from CC list since his mail server is timing out.)

On Fri, Sep 14, 2001 at 12:50:54PM -0600, Cort Dougan wrote:
> Only the PPC-based gemini board uses that driver (ncr885e) and Val is the
> maintainer of that board.  These patches that she sent fix yellowfin.c for
> the ncr885e chip on the big-endian PPC.  I just pointed at the junk pile,
> Val is actually doing the work to put the ncr885e drivers there.

Yep, exactly.  Here's the revised patch.  It lists the yellowfin
driver once in Config.in, removes the ncr885e driver, and changes the
#ifdef __powerpc__ to #ifdef __BIG_ENDIAN.

Unfortunately, the patch is now 56K.  It's available for download
here:

http://www.nmt.edu/~val/patches/yellowfinpatch

-VAL
