Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWIETwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWIETwh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWIETwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:52:37 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:13737 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030235AbWIETwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:52:36 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44FDD55D.8010205@s5r6.in-berlin.de>
Date: Tue, 05 Sep 2006 21:51:57 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive locking
 detected
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>	 <20060905111306.80398394.akpm@osdl.org>	 <a44ae5cd0609051116k6c236ba6xa2fd0119708a6950@mail.gmail.com>	 <44FDC9F5.3090605@s5r6.in-berlin.de> <a44ae5cd0609051219p5962b62ek8dd695d3f3c88fa4@mail.gmail.com>
In-Reply-To: <a44ae5cd0609051219p5962b62ek8dd695d3f3c88fa4@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> The patch doesn't apply cleanly, but I suspect this is no big deal.
> 
> patch -p1 -R <
> /home/miles/119-ieee1394-nodemgr-convert-nodemgr_serialize-semaphore-to-mutex.patch
> 
> patching file drivers/ieee1394/nodemgr.c
> Hunk #2 succeeded at 1630 (offset 9 lines).
> Hunk #3 succeeded at 1659 (offset 9 lines).
> Hunk #4 succeeded at 1677 (offset 9 lines).

Yes, these offsets are harmless.

Thanks for the help to debug this.
-- 
Stefan Richter
-=====-=-==- =--= --=-=
http://arcgraph.de/sr/
