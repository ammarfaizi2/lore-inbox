Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVCSHQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVCSHQB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 02:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVCSHQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 02:16:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:12977 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262425AbVCSHPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 02:15:50 -0500
Date: Fri, 18 Mar 2005 23:15:15 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: chrisw@osdl.org, torvalds@osdl.org, akpm@osdl.org
Subject: Linux 2.6.11.5
Message-ID: <20050319071515.GA22754@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the -stable patch review cycle is now over, I've released the
2.6.11.5 kernel in the normal kernel.org places.  One patch was deemed
incorrect, so it was dropped.  Another one was added, within the review
email thread.  So it seems like the process is working so far, which is
refreshing :)

The diffstat and short summary of the fixes are below.  

I'll also be replying to this message with a copy of the patch between
2.6.11.4 and 2.6.11.5, as it is small enough to do so.

thanks,
 
greg k-h

------
 Makefile                    |    2 +-
 drivers/net/amd8111e.c      |    2 ++
 drivers/net/tun.c           |    2 +-
 drivers/net/via-rhine.c     |    4 +++-
 drivers/net/wan/hd6457x.c   |    2 +-
 kernel/signal.c             |    1 +
 net/ipv4/fib_hash.c         |   12 +++++++++++-
 net/netrom/nr_in.c          |    9 ---------
 net/xfrm/xfrm_state.c       |    2 +-
 sound/pci/ac97/ac97_codec.c |   13 ++++++++-----
 10 files changed, 29 insertions(+), 20 deletions(-)


Summary of changes from v2.6.11.4 to v2.6.11.5
==============================================

<dilinger:debian.org>:
  o Possible AMD8111e free irq issue
  o Possible VIA-Rhine free irq issue

Daniel Drake:
  o Fix stereo mutes on Surround volume control

David S. Miller:
  o [IPSEC]: Fix __xfrm_find_acq_byseq()

Greg Kroah-Hartman:
  o Linux 2.6.11.5

Hugh Dickins:
  o tasklist left locked

Krzysztof Halasa:
  o Fix kernel panic on receive with WAN Hitachi SCA HD6457x

Patrick McHardy:
  o Fix crash while reading /proc/net/route

Ralf Bächle:
  o NetROM locking

Stephen Hemminger:
  o Fix check for underflow

