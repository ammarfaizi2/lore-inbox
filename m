Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbUBZCnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbUBZCnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:43:18 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:20878 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262610AbUBZCnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:43:13 -0500
Message-ID: <403D5D32.4010007@matchmail.com>
Date: Wed, 25 Feb 2004 18:42:58 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com>
In-Reply-To: <403D576A.6030900@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> 2. have a user space daemon poll running tasks periodically and renice 
> them if they are running specified binaries
> 
> Both of these solutions have their advantages and disadvantages, are 
> (obviously) complicated than I've made them sound and would require a 
> great deal of care to be taken during their implementation.  However, I 
> think that they are both doable.  My personal preference would be for 
> the in kernel solution on the grounds of efficiency.

Better would be to have the kernel tell the daemon whenever a process in 
exec-ed, and you have simplicity in the kernel, and policy in user space.
