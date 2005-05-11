Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVEKXDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVEKXDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 19:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVEKXB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 19:01:26 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:27316 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261635AbVEKW5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:57:20 -0400
Message-ID: <42828CF0.2080400@ammasso.com>
Date: Wed, 11 May 2005 17:53:36 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: William Jordan <bjordan.ics@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <20050411171347.7e05859f.akpm@osdl.org> <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com> <4279142A.8050501@ammasso.com> <427A6A7E.8000604@ammasso.com> <427BF8E1.2080006@ammasso.com> <Pine.LNX.4.61.0505071304010.4713@goblin.wat.veritas.com> <427CD49E.6080300@ammasso.com> <Pine.LNX.4.61.0505071617470.5718@goblin.wat.veritas.com> <78d18e2050511131246075b37@mail.gmail.com> <20050511224947.GL6313@g5.random>
In-Reply-To: <20050511224947.GL6313@g5.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> If the problem appears again even after the last fix for the COW I did
> last year, than it means we've another yet another bug to fix.

All of my memory pinning test cases pass when I use get_user_pages() with kernels 2.6.7 
and later.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
