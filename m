Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTE1XcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTE1XcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:32:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50023 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261704AbTE1XcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:32:04 -0400
Date: Wed, 28 May 2003 19:45:20 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200305282345.h4SNjKv02989@devserv.devel.redhat.com>
To: Richard Braakman <dark@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for strncmp use in s390 in 2.5
In-Reply-To: <mailman.1054159021.10246.linux-kernel2news@redhat.com>
References: <20030528162019.A3492@devserv.devel.redhat.com> <mailman.1054159021.10246.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I didn't see this posted before. Sorry if I missed it.
>> It's a harmless buglet which causes false positives with correctness
>> checking tools, and so annoys me.
> 
> Are you sure it's harmless?  Your patch changes the meaning from an
> exact match to a prefix match.  I think it's intended to be an exact
> match, but I don't know why it doesn't just use strcmp().

The buglet is harmless. Now, the fix perhaps not.
I think it may be better to replace it with strcmp, too.

-- Pete
