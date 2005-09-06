Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVIFQPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVIFQPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 12:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVIFQPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 12:15:25 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:41763 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750736AbVIFQPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 12:15:25 -0400
To: Harald Welte <laforge@gnumonks.org>
Cc: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
X-Message-Flag: Warning: May contain useful information
References: <20050904101218.GM4415@rama.de.gnumonks.org>
	<200509031627.00947.chase.venters@clientec.com>
	<20050904112032.GO4415@rama.de.gnumonks.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 06 Sep 2005 09:15:10 -0700
Message-ID: <52k6huuq9d.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Sep 2005 16:15:12.0452 (UTC) FILETIME=[28B82040:01C5B2FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Harald> Obviously, if HZ would ever go below 100, the code above
    Harald> would provide some problems.  I'm not sure what the future
    Harald> plans with HZ are, but I'll add an #error statement in
    Harald> case HZ goes smaller than that.

It might be simpler just to define it to msecs_to_jiffies(10).

 - R.
