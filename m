Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWIAPf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWIAPf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWIAPf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:35:58 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:32179 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751639AbWIAPf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:35:57 -0400
Message-ID: <44F85267.1000607@s5r6.in-berlin.de>
Date: Fri, 01 Sep 2006 17:31:51 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Roman Zippel <zippel@linux-m68k.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
References: <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de> <44F44B8D.4010700@s5r6.in-berlin.de> <Pine.LNX.4.64.0608300311430.6761@scrub.home> <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de> <Pine.LNX.4.64.0608310039440.6761@scrub.home> <1157069717.2347.13.camel@shinybook.infradead.org> <20060831174852.18efec7e.rdunlap@xenotime.net> <1157074048.2347.24.camel@shinybook.infradead.org> <20060901134425.GA32440@wohnheim.fh-wedel.de>
In-Reply-To: <20060901134425.GA32440@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
...
> The actual problem existed before select just as it does afterwards.
> People have to search extensively though Kconfig files to come up with
> a useful .config.  Before people had to magically know that
> USB_STORAGE requires SCSI.  "Magically" because USB_STORAGE didn't
> show up in either make menuconfig, make xconfig or .config.  Now
> people have to magically know that SCSI=n requires USB_STORAGE=n.

Yes and no. In the latter case, they have to magically know that at
least menuconfig and xconfig can be tricked to list depending options.

> What this shows is that select was a bad idea, as it merely shifted
> the problem around instead of fixing it.  It appears as if Stefan is
> looking in the right direction for a decent fix and I'd like to see
> patches from him.
...

Could be a fun project right after Stefan R got rid of the kernel
freezes (months old) and data corruptions (years old) assigned to him at
bugzilla.kernel.org...
-- 
Stefan Richter
-=====-=-==- =--= ----=
http://arcgraph.de/sr/
