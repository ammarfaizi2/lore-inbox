Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbUBZTtt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbUBZTtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:49:47 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:9205 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262970AbUBZTsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:48:15 -0500
Message-ID: <403E4D66.3040608@matchmail.com>
Date: Thu, 26 Feb 2004 11:47:50 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Peter Williams <peterw@aurema.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403D5D32.4010007@matchmail.com> <403E1A7A.6030804@techsource.com>
In-Reply-To: <403E1A7A.6030804@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> How about this:
> 
> The kernel tracks CPU usage, time slice expiration, and numerous other 
> statistics, and exports them to userspace through /proc or somesuch. 
> Then a user-space daemon adjusts priority.  This could work, but it 
> would be sluggish in adjusting priorities.

Userspace shouldn't have to poll, especially if there needs to be low 
latency in the interaction.
