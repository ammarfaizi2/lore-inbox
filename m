Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292081AbSBAVlq>; Fri, 1 Feb 2002 16:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292084AbSBAVlg>; Fri, 1 Feb 2002 16:41:36 -0500
Received: from holomorphy.com ([216.36.33.161]:4233 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S292081AbSBAVlZ>;
	Fri, 1 Feb 2002 16:41:25 -0500
Date: Fri, 1 Feb 2002 13:41:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adam McKenna <adam-dated-1013027573.f251b8@flounder.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: should I trust 'free' or 'top'?
Message-ID: <20020201214120.GE834@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adam McKenna <adam-dated-1013027573.f251b8@flounder.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020201192415.GC23997@flounder.net> <20020201201145.GD834@holomorphy.com> <20020201203250.GD23997@flounder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020201203250.GD23997@flounder.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 12:11:45PM -0800, William Lee Irwin III wrote:
>> What kernel/VM are you using?

On Fri, Feb 01, 2002 at 12:32:50PM -0800, Adam McKenna wrote:
> 2.4.6-xfs but we've also seen this with 2.4.14-xfs (xfs 1.0.2 release)

You appear to be in more trouble than I can get you out of. Could you
try again with -aa or -rmap against a recent kernel? (mainline VM appears
not to behave as well as either of these).

On Fri, Feb 01, 2002 at 12:11:45PM -0800, William Lee Irwin III wrote:
>> Could you follow up with /proc/slabinfo and /proc/meminfo?

On Fri, Feb 01, 2002 at 12:32:50PM -0800, Adam McKenna wrote:
> We've already rebooted the box, next time we are experiencing the problem
> I'll send this info.
> Meanwhile, is there any way to tune the kernel cache?

Kernel hacking. Until you get yourself a stabler VM it probably won't
be meaningful to try that directly, though making this tunable would be
nice, too. I've heard it's difficult to merge xfs with VM changes due to
its invasiveness in the VM, but I've heard of it being done several times.

Cheers,
Bill
