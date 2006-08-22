Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWHVP6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWHVP6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWHVP6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:58:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:31936 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751324AbWHVP6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:58:44 -0400
Date: Tue, 22 Aug 2006 21:28:07 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-ID: <20060822155807.GA12943@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <20060820174839.GH13917@in.ibm.com> <1156245036.6482.16.camel@Homer.simpson.net> <20060822101028.GB5052@in.ibm.com> <1156257674.4617.8.camel@Homer.simpson.net> <1156260209.6225.7.camel@Homer.simpson.net> <20060822140124.GC7125@in.ibm.com> <1156269661.4954.6.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156269661.4954.6.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 06:01:01PM +0000, Mike Galbraith wrote:
> Yeah, a sleep/burn loop.  The proggy is a one of several scheduler
> exploits posted to lkml over the years.  The reason I wanted to test
> this patch set was to see how well it handles various nasty loads.

Ok ..thanks for pointing me to it. I am testing it now and will post my
observations soon.

That said, I think this patch needs more work, especially in the area
of better timeslice management and SMP load-balance. If you have any
comments on its general design and the direction in which this is
proceeding, I would love to hear them.

Thanks for your feedback so far on this!

-- 
Regards,
vatsa
