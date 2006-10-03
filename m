Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWJCPUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWJCPUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWJCPUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:20:46 -0400
Received: from mga05.intel.com ([192.55.52.89]:39018 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S964798AbWJCPUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:20:46 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,251,1157353200"; 
   d="scan'208"; a="140951372:sNHT1232257124"
Message-ID: <1479.10.24.212.168.1159888832.squirrel@linux.intel.com>
In-Reply-To: <200610030816.27941.reinette.chatre@linux.intel.com>
References: <200610030816.27941.reinette.chatre@linux.intel.com>
Date: Tue, 3 Oct 2006 08:20:32 -0700 (PDT)
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of 
     a user buffer
From: inaky@linux.intel.com
To: "Reinette Chatre" <reinette.chatre@linux.intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Inaky Perez-Gonzalez" <inaky@linux.intel.com>
User-Agent: SquirrelMail/1.4.6-7.el4.centos4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew

We are going to use this in the Linux UWB project; is it
possible/makes it sense to get it in?

> lib/bitmap.c:bitmap_parse() is a library function that received as input a
>  user buffer. This seemed to have originated from the way the write_proc
> function of the /proc filesystem operates.
>
> This function will be useful for other uses as well; for example, taking
> input  for /sysfs instead of /proc, so it was changed to accept kernel
> buffers. We have this use for the Linux UWB project, as part as the
> upcoming bandwidth allocator code.
>
> Only a few routines used this function and they were changed too.
>
> Signed-off-by: Reinette Chatre <reinette.chatre@linux.intel.com>
Signed-off-by: Inaky Perez-Gonzalez <inaky@linux.intel.com>

-- Inaky
