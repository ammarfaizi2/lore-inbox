Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWHWNZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWHWNZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWHWNZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:25:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:62626 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932097AbWHWNZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:25:52 -0400
Date: Wed, 23 Aug 2006 18:55:08 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-ID: <20060823132508.GC21884@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <20060820174839.GH13917@in.ibm.com> <1156326208.6265.33.camel@Homer.simpson.net> <1156346683.6456.4.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156346683.6456.4.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 03:24:43PM +0000, Mike Galbraith wrote:
> On Wed, 2006-08-23 at 09:43 +0000, Mike Galbraith wrote:
> 
> > ...and after my box finishes rebooting, I'll alert the developer of this
> > patch set that very bad things happen the instant you do that :)
> 
> Good news is that it doesn't always spontaneous reboot.  Sometimes, it
> just goes pop.

Using the top-level cpuset itself is something that I don't think the
patches support yet. Shouldnt be hard to make it work, except usage of
tasks in the top-level cpuset need to be accounted/controlled. I am working on 
this now and as well some changes wrt timeslice management. Will send out some
patches soon!

-- 
Regards,
vatsa
