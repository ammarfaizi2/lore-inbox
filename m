Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269394AbUINSrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269394AbUINSrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269521AbUINSpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:45:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:13745 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269334AbUINSoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:44:10 -0400
Date: Tue, 14 Sep 2004 13:43:27 -0500
From: Greg Edwards <edwardsg@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, paulmck@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
Message-ID: <20040914184327.GM4178@sgi.com>
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408192016.10064.jbarnes@engr.sgi.com> <20040820155717.GF1243@us.ibm.com> <200408201324.32464.jbarnes@engr.sgi.com> <41265CCE.3070808@colorfullife.com> <20040910190153.GA32062@sgi.com> <4145E50E.2020300@colorfullife.com> <20040914175241.GI4178@sgi.com> <41473578.7000106@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41473578.7000106@colorfullife.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:16:24PM +0200, Manfred Spraul wrote:
| Greg Edwards wrote:
| 
| >Manfred,
| >
| >Lockstat output attached from 2.6.9-rc2 at 512p and 2.6.9-rc2 + your two
| >remaining RCU patches at 512p.  kernbench was run without any arguments.
| >
| >The difference for RCU looks great.
| >
| > 
| >
| Which value did you use for RCU_GROUP_SIZE? I'm not sure what's the 
| optimal value for 512p - probably 32 or so.

I used what was defined in the patch

+#define RCU_GROUP_SIZE 2

I can try running with a couple different values and see how it looks.

Greg
