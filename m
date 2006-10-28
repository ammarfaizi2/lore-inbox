Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWJ1EGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWJ1EGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 00:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbWJ1EGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 00:06:43 -0400
Received: from mx1.suse.de ([195.135.220.2]:21738 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751718AbWJ1EGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 00:06:43 -0400
From: Andi Kleen <ak@suse.de>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: AMD X2 unsynced TSC fix?
Date: Fri, 27 Oct 2006 21:06:12 -0700
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
References: <1161969308.27225.120.camel@mindpipe> <1161986902.27225.206.camel@mindpipe> <1162007907.26022.13.camel@localhost.localdomain>
In-Reply-To: <1162007907.26022.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610272106.13115.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So far, has I can understand. Seems to me that my computer which have a
> Pentium D (Dual Core) on VIA chipset, also have unsynchronized TSC and
> with the patch of hrtimers on

Intel systems (except for some large highend systems) have synchronized TSCs. 
Only exception so far seems to be a few systems that are 
overclocked/overvolted and running outside their specification. 
When you do that you'e on your own and we're not interested in a bug
report.

There was also one BIOS found that had this problem, but it was old and rare
and got fixed with a upgrade.

> Just to point out. This could be more a problem of chipsets than CPUs
> (AMD or Intel). AMD just begin first using x86_64 archs :)

No.

-Andi
