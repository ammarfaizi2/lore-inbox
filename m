Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVLRHFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVLRHFI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 02:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbVLRHFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 02:05:07 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:24326 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932448AbVLRHFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 02:05:06 -0500
Date: Sun, 18 Dec 2005 08:04:54 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Vijay Sampath <vsampath@gmail.com>
Cc: gcoady@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTD (kernel 2.4.32): kernel stuck in tight loop occasionally on flash access
Message-ID: <20051218070454.GH15993@alpha.home.local>
References: <02DAE179D5CEED4C992055C823ED90FF8ACE8E@ex1> <758a2bbf0512171759i35df21e7t8a1b00f72c362614@mail.gmail.com> <758a2bbf0512171821j5be863c1x8d6b35e67f5f1fea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <758a2bbf0512171821j5be863c1x8d6b35e67f5f1fea@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 06:21:26PM -0800, Vijay Sampath wrote:
> > >         Something is wrong here?  Your patch should not alter dontdiff.
> >
> > It didn't. 2.4 kernel doesn't have dontdiff, so I had to download it.
> > But I only downloaded to one of the directories, hence the messed up
> > output. Maybe dontdiff should have "dontdiff" as one of the files not
> > to diff! :)
> 
> Sorry for another mail, but please let me know if I should resubmit
> the patch without the dontdiff problem.

It would be better, because if your patch is merged, the description
and the patch will be extracted from your mail. Please also fix the
description about TASK_UNINTERRUPTIBLE. BTW, is there a particular
reason for TASK_UNINTERRUPTIBLE ? Or maybe you simply found it in
another driver ?

Regards,
Willy

