Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbTLGSc0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 13:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTLGSc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 13:32:26 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:31874
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264484AbTLGScY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 13:32:24 -0500
Date: Sun, 7 Dec 2003 13:31:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
In-Reply-To: <1039560000.1070817418@[10.10.2.4]>
Message-ID: <Pine.LNX.4.58.0312071330290.1758@montezuma.fsmlabs.com>
References: <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth>
 <392900000.1070737269@[10.10.2.4]> <Pine.LNX.4.58.0312061601400.1758@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0312071433300.28463@earth> <20031207163914.GB19412@krispykreme>
 <1039560000.1070817418@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Dec 2003, Martin J. Bligh wrote:

> >> i've seen a similar crash once on a 2-way (4-way) HT box, so there some
> >> startup race going on most likely.
> >
> > Im seeing bootup crashes every now and then on a ppc64 box too. A few
> > other things Ive noticed:

Just a datapoint, the migration_queue list appears to be getting
'corrupted' the ->next pointer is NULL on entry to migration_task.
