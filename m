Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271969AbTGYKcR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 06:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271973AbTGYKcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 06:32:16 -0400
Received: from gw-nl4.philips.com ([212.153.190.6]:54221 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP id S271969AbTGYKcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 06:32:15 -0400
Message-ID: <3F210AF5.5000909@basmevissen.nl>
Date: Fri, 25 Jul 2003 12:48:21 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
Cc: diegocg@teleline.es, rpjday@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
References: <200307241829.h6OITjR3000582@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200307241829.h6OITjR3000582@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> A CONFIG_KNOWN_BROKEN option is a good thing, in the case where,
> E.G. a SCSI driver is broken, and will randomly corrupt data, but
> otherwise compiles and appears to work.  

I agree on that.

Maybe I should make my point more clear. What bothers me is that a lot 
of (early 2.4) kernel versions could easely be configured non-compiling. 
Not just for exotic configurations, but also when building for an 
average PC.

That is very confusing (and anoying) for all kernel builders, as you can 
not always easely tell if the kernel doesn't compile because of 
misconfiguration or because of code errors.

I hope that this can be avoided for 2.6.0. "Fixing" device drivers by 
calling them obsolete, is not the right way. Because drivers that are 
broken and fixed by nobody might not be obsolete.

So for 2.6.0, I propose to only mark obsolete what is really obsolete. 
Maybe everything that is broken since 2.2 and nobody complained about 
it. Then, mark broken what is broken for some time and nobody is 
(currenly) willing/able to fix.

Bas.



