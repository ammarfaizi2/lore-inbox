Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWISTl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWISTl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWISTl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:41:27 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26280
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751037AbWISTl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:41:26 -0400
Date: Tue, 19 Sep 2006 12:41:31 -0700 (PDT)
Message-Id: <20060919.124131.130617144.davem@davemloft.net>
To: master@sectorb.msk.ru
Cc: kuznet@ms2.inr.ac.ru, ak@suse.de, hawk@diku.dk, harry@atmos.washington.edu,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060918220331.GB32520@tentacle.sectorb.msk.ru>
References: <20060918211759.GB31746@tentacle.sectorb.msk.ru>
	<20060918220038.GB14322@ms2.inr.ac.ru>
	<20060918220331.GB32520@tentacle.sectorb.msk.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Date: Tue, 19 Sep 2006 02:03:31 +0400

> On Tue, Sep 19, 2006 at 02:00:38AM +0400, Alexey Kuznetsov wrote:
> > * I do see get_offset_pmtmr() in top lines of profile. That's scary enough.
> 
> I had it at the very top line.

That is just rediculious.

You can "fix" the networking by making it timestamp less but what
about things like just normal X11 clients that call gettimeofday()
at very high rates?
