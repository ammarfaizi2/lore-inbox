Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUHVG01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUHVG01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 02:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266380AbUHVG01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 02:26:27 -0400
Received: from pumpkin.explorerforum.com ([209.209.36.42]:22742 "EHLO
	pumpkin.explorerforum.com") by vger.kernel.org with ESMTP
	id S266362AbUHVG0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 02:26:20 -0400
Message-ID: <41283C84.20500@lbl.gov>
Date: Sat, 21 Aug 2004 23:26:12 -0700
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.6.8.1-mm3
References: <20040820031919.413d0a95.akpm@osdl.org> <412821C4.7060402@lbl.gov> <20040821214824.4bf5e6fd.akpm@osdl.org> <412827DF.1080408@yahoo.com.au>
In-Reply-To: <412827DF.1080408@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.9 (pumpkin.explorerforum.com [209.209.36.42]); Sat, 21 Aug 2004 23:34:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> If you get time, could you try turning off CONFIG_SCHED_SMT - if that still
> doesn't help, try turning off hyperthreading completely. Thanks.
>

Doing this fixed it; it also runs fine under 2.6.8.1 with SMT turned on.

thomas
