Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUDNP1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUDNP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:27:33 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:32740 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264272AbUDNP0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:26:54 -0400
Date: Wed, 14 Apr 2004 08:21:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: arjanv@redhat.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       "'Andy Whitcroft'" <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Lse-tech] Re: hugetlb demand paging patch part [0/3]
Message-ID: <17200000.1081956095@[10.10.2.4]>
In-Reply-To: <1081933442.4688.6.camel@laptop.fenrus.com>
References: <200404132317.i3DNH4F21162@unix-os.sc.intel.com> <1081933442.4688.6.camel@laptop.fenrus.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In addition to the hugetlb commit handling that we've been working on
>> off the list, Ray Bryant of SGI and I are also working on demand paging
>> for hugetlb page.  Here are our final version that has been heavily
>> tested on ia64 and x86.  I've broken the patch into 3 pieces so it's
>> easier to read/review, etc.
> 
> Ok I think it's time to say "HO STOP" here.
> 
> If you're going to make the kernel deal with different, concurrent page
> sizes then please do it for real. Or alternatively leave hugetlb to be
> the kludge/hack it is right now. Anything inbetween is the road to
> madness...

I'd prefer to see it walk step by step to "doing it for real" than have
a huge cataclysmic patch that breaks everything ....

M.

