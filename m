Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbSKOCch>; Thu, 14 Nov 2002 21:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSKOCcg>; Thu, 14 Nov 2002 21:32:36 -0500
Received: from franka.aracnet.com ([216.99.193.44]:4038 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265603AbSKOCcg>; Thu, 14 Nov 2002 21:32:36 -0500
Date: Thu, 14 Nov 2002 18:35:47 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <396026666.1037298946@[10.10.2.3]>
In-Reply-To: <1037325839.13735.4.camel@rth.ninka.net>
References: <1037325839.13735.4.camel@rth.ninka.net>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While I have this on my mind I want to express this now since the
> very first bug that hit my mailbox had this issue.
> 
> I DO NOT want to be working on bugs on anything other than Linus's
> actualy sources.  The first bug I got was a networking bug with
> Andrew Morton's -mm patches applied.
> 
> This isn't going to work if that is what people are going to be
> allowed to do.
> 
> I want to suggest that all reported bug in the database must be
> reporducable with some release done by Linus or his BK sources.
> And also that we can automatically close any BUG submissions that
> have other patches applied.

Hmmm ... I'm not sure that being that restrictive is going to help.
Whilst bugs against any randomly patched version of the kernel
probably aren't that interesting, things in major trees like -mm, 
-ac, -dj etc are likely going to end up in mainline sooner or later
anyway ... wouldn't you rather know of the breakage sooner rather
than later?

Recall when some random idiot broke sparc64 by mucking with 
free_area_init_node? Those changes had been sitting in -mm tree
for a while ;-) (and yes, that was me).

M.

