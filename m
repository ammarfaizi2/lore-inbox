Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbSKTIhI>; Wed, 20 Nov 2002 03:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSKTIhI>; Wed, 20 Nov 2002 03:37:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15040 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265895AbSKTIhH>;
	Wed, 20 Nov 2002 03:37:07 -0500
Date: Wed, 20 Nov 2002 09:44:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@tech9.net>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove magic numbers in block queue initialization
Message-ID: <20021120084401.GH11884@suse.de>
References: <1037747198.1252.2259.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037747198.1252.2259.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19 2002, Robert Love wrote:
> Andrew,
> 
> Your less-requests patch signaled a way-too-many magic numbers alarm
> (not the patches fault, of course, but it pointed it out).
> 
> Attached patch removes the minimum queue length, maximum queue length,
> factor of queue length that is number of batch requests, and the maximum
> number of batch request magic numbers and replaces them with defines and
> some comments.
> 
> Look OK?

No, please leave these alone, testing is on-going in these parts right
now.

-- 
Jens Axboe

