Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUDNPa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUDNPaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:30:52 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:16620 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264257AbUDNP3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:29:00 -0400
Date: Wed, 14 Apr 2004 08:23:45 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: arjanv@redhat.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       "'Andy Whitcroft'" <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Lse-tech] Re: hugetlb demand paging patch part [0/3]
Message-ID: <17980000.1081956225@[10.10.2.4]>
In-Reply-To: <17200000.1081956095@[10.10.2.4]>
References: <200404132317.i3DNH4F21162@unix-os.sc.intel.com> <1081933442.4688.6.camel@laptop.fenrus.com> <17200000.1081956095@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> In addition to the hugetlb commit handling that we've been working on
>>> off the list, Ray Bryant of SGI and I are also working on demand paging
>>> for hugetlb page.  Here are our final version that has been heavily
>>> tested on ia64 and x86.  I've broken the patch into 3 pieces so it's
>>> easier to read/review, etc.
>> 
>> Ok I think it's time to say "HO STOP" here.
>> 
>> If you're going to make the kernel deal with different, concurrent page
>> sizes then please do it for real. Or alternatively leave hugetlb to be
>> the kludge/hack it is right now. Anything inbetween is the road to
>> madness...
> 
> I'd prefer to see it walk step by step to "doing it for real" than have
> a huge cataclysmic patch that breaks everything ....

Hmm - maybe that could be misinterpreted ;-) I meant that this the patches
discussed here are the steps (ie good ;-)), not the cataclysmic event.

M.

