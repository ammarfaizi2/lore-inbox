Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318072AbSGWObV>; Tue, 23 Jul 2002 10:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318073AbSGWObV>; Tue, 23 Jul 2002 10:31:21 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:57018 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S318072AbSGWObT>; Tue, 23 Jul 2002 10:31:19 -0400
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
From: Steven Cole <elenstev@mesatop.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Ed Tomlinson <tomlins@cam.org>
In-Reply-To: <Pine.LNX.4.44.0207221520301.14311-100000@loke.as.arizona.edu>
References: <Pine.LNX.4.44.0207221520301.14311-100000@loke.as.arizona.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Jul 2002 08:31:05 -0600
Message-Id: <1027434665.12588.78.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 16:36, Craig Kulesa wrote:
> 
> On Mon, 22 Jul 2002, William Lee Irwin III wrote:
> 
> > The pte_chain mempool was ridiculously huge and the use of mempool for
> > this at all was in error.
> 
[snipped]
> 
> in dquot.c.  It'll be tested and fixed on the next go. :)

1st the good news.  The 2.5.27-rmap-2b-dqcache patch fixed the compile
problem with CONFIG_QUOTA=y.

Then, I patched in 2.5.27-rmap-3-slaballoc from Craig's site and the
test machine got much further in the boot, but hung up here:

Starting cron daemon
/etc/rc.d/rc3.d/S50inet: fork: Cannot allocate memory

Sorry, no further information was available.

Steven

