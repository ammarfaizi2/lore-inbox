Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWFDBlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWFDBlm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 21:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWFDBlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 21:41:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751259AbWFDBll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 21:41:41 -0400
Date: Sat, 3 Jun 2006 18:41:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, linux-ide@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2+ahci resume] NULL pointer dereference in
 cfq_dispatch_requests
Message-Id: <20060603184134.ee6dcc3b.akpm@osdl.org>
In-Reply-To: <4482389F.6030403@goop.org>
References: <4482389F.6030403@goop.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Jun 2006 18:34:23 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

>     BUG: unable to handle kernel NULL pointer dereference at virtual
>     address 00000054
> 
> in cfq_dispatch_requests+0x2c5/0x454.
> 
> I'm running 2.6.17-rc5-mm2 with Forrest Zhao's ahci resume patches of 
> the other day.
> 
> The system was basically idle with very little IO going on.  It happens 
> fairly regularly, but not triggered by any particular activity.  The 
> system had not been through a suspend/resume cycle.

There have been a number of CFQ fixes post-2.6.17-rc5-mm2.  Fingers
crossed, please test -mm3.  Hopefully I'll have that out 4-6 hours hence.


