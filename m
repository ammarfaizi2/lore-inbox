Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbUBZTuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUBZTuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:50:04 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:32136 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262943AbUBZTrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:47:04 -0500
Message-ID: <403E4D1B.9060503@matchmail.com>
Date: Thu, 26 Feb 2004 11:46:35 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Peter Williams <peterw@aurema.com>, Timothy Miller <miller@techsource.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403D5D32.4010007@matchmail.com> <403D71AB.9060609@aurema.com> <403D73B4.4060600@matchmail.com> <403E47C4.4080104@watson.ibm.com>
In-Reply-To: <403E47C4.4080104@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
>>> Mike Fedyk wrote:
>>>> Better would be to have the kernel tell the daemon whenever a 
>>>> process in exec-ed, and you have simplicity in the kernel, and 
>>>> policy in user space.
> 
> 
> 
> As it turns out, one can still use a fairly simple in-kernel module 
> which provides a *mechanism* for effectively changing a process' 
> entitlement while retaining the policy component in userland.

How much code could be removed if CKRM triggered a userspace process to 
perform the operations required?
