Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbUCJG5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 01:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUCJG5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 01:57:49 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:60167 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S262232AbUCJG5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 01:57:48 -0500
Message-ID: <404EBC64.8070708@cs.wisc.edu>
Date: Tue, 09 Mar 2004 22:57:40 -0800
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] set request fastfail bit
References: <404EB824.1030806@cs.wisc.edu>
In-Reply-To: <404EB824.1030806@cs.wisc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie wrote:
> The first three bio and request flags are no longer identical.
> The bio barrier and rw flags are getting set in __make_request
       ^^^

That should have said request not bio.

> and get_request respectively, and failfast is getting
> left out. The attached patch (built against 2.6.4-rc3)
> sets the request's failfast flag in __make_request when the bio's
> flag is set.

