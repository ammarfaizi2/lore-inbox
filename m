Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbUBZQFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbUBZQCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:02:39 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:7693 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262809AbUBZQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:00:19 -0500
Message-ID: <403E1A7A.6030804@techsource.com>
Date: Thu, 26 Feb 2004 11:10:34 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Peter Williams <peterw@aurema.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403D5D32.4010007@matchmail.com>
In-Reply-To: <403D5D32.4010007@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about this:

The kernel tracks CPU usage, time slice expiration, and numerous other 
statistics, and exports them to userspace through /proc or somesuch. 
Then a user-space daemon adjusts priority.  This could work, but it 
would be sluggish in adjusting priorities.

I still like Nick and Con's solutions better.

