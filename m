Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVASUNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVASUNo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVASUNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:13:44 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:18662 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261867AbVASUNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:13:33 -0500
Date: Wed, 19 Jan 2005 15:13:30 -0500
From: "Bill Rugolsky Jr." <brugolsky@yahoo.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Jan Knutar <jk-lkml@sci.fi>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] /proc/<pid>/rlimit
Message-ID: <20050119201329.GC22710@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@yahoo.com>,
	Chris Wright <chrisw@osdl.org>, Jan Knutar <jk-lkml@sci.fi>,
	linux-kernel@vger.kernel.org
References: <20050118204457.GA7824@ti64.telemetry-investments.com> <200501192131.59252.jk-lkml@sci.fi> <20050119113803.I469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119113803.I469@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 11:38:03AM -0800, Chris Wright wrote:
> * Jan Knutar (jk-lkml@sci.fi) wrote:
> > A "cool feature" would be if you could do
> > echo nofile 8192 8192 >/proc/`pidof thatserverproess`/rlimit
> > :-)
> 
> This is security sensitive, and is currently only expected to be changed
> by current.

Sure, I had thought of implementing it, paused to consider the security
implications, and then punted.

Chris, on the other point that you made regarding UGO read access to "rlimit",
the same is true of "maps" (at least sans SELinux policy), so I don't
see an issue.  Certainly the map information is more security sensitive.

Regards,

	-Bill
