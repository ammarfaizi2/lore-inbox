Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVKJPuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVKJPuE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 10:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVKJPuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 10:50:04 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:32473 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751027AbVKJPuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 10:50:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Alexander Clouter <alex-kernel@digriz.org.uk>
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Date: Fri, 11 Nov 2005 02:48:57 +1100
User-Agent: KMail/1.8.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davej@redhat.com,
       davej@codemonkey.org.uk, blaisorblade@yahoo.it
References: <20051110151111.GA16994@inskipp.digriz.org.uk>
In-Reply-To: <20051110151111.GA16994@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511110248.58751.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005 02:11, Alexander Clouter wrote:
> The use of the 'ignore_nice' sysfs file is confusing to anyone using it.
> This removes the sysfs file 'ignore_nice' and in its place creates a
> 'ignore_nice_load' entry which defaults to '1'; meaning nice'd processes
> are not counted towards the 'business' caclulation.

And just for the last time I'll argue that the default should be 0. I have yet 
to discuss this with any laptop user who thinks that 1 is the correct default 
for ondemand.

Regards,
Con
